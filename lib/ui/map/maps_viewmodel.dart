import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsViewModel with ChangeNotifier {
  Completer<GoogleMapController> controller = Completer();
  Position? position;

  CameraPosition initialLocation() {
    return CameraPosition(
      target: LatLng(position?.latitude ?? 37.42796133580664,
          position?.longitude ?? -122.085749655962),
      zoom: 14.4746,
    );
  }

  Future<void> _goToMyLocation() async {
    var position = await _determinePosition();
    this.position = position;
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position.latitude, position.longitude),
        zoom: 19.151926040649414)));
  }

  MapsViewModel() {
    _goToMyLocation();
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
