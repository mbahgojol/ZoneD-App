import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoned/data/model/FeedModel.dart';

import '../../data/remote/firebase_service.dart';
import '../../utils/result_state.dart';

class MapsViewModel with ChangeNotifier {
  Completer<GoogleMapController> controller = Completer();
  FirebaseService service = FirebaseService();
  ResultState state = ResultState.Initial;
  Set<Circle> circles = {};
  double latitude = 0;
  double longitude = 0;
  bool isShow = false;
  FeedModel? feedModel;

  void showIncidentDialog(FeedModel feedModel) {
    isShow = !isShow;
    this.feedModel = feedModel;
    notifyListeners();
  }

  Future<void> setLocation(double latitude, double longitude) async {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  Future<void> _goToMyLocation() async {
    var position = await _determinePosition();
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16.4746,
    )));
  }

  MapsViewModel() {
    if (latitude == 0 && longitude == 0) {
      _goToMyLocation();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
