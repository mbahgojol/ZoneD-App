import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:zoned/utils/result_state.dart';

import '../../data/model/FeedModel.dart';
import '../../data/remote/firebase_service.dart';

class CreateFeedsViewModel with ChangeNotifier {
  String? path;
  Position? position;
  String? title;
  String? description;
  int? incident;
  FirebaseService service = FirebaseService();
  ResultState state = ResultState.Initial;

  CreateFeedsViewModel() {
    getMyLocation();
  }

  void clearData() {
    path = null;
    title = null;
    description = null;
    incident = null;
    notifyListeners();
  }

  void setPath(String path) {
    this.path = path;
    notifyListeners();
  }

  Future<void> postingFeed(Function() loading, Function() done) async {
    try {
      state = ResultState.Loading;
      notifyListeners();
      loading();

      var url = await service.saveFile(path!);
      var id = const Uuid().v1();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position?.latitude ?? 0,
        position?.longitude ?? 0,
      );

      service.addFeeds(FeedModel(
        title: title ?? "",
        description: description ?? "",
        voteUp: "0",
        voteDown: "0",
        id: id,
        typeReport: 0,
        userId: "",
        username: "Ghozi Mahdi",
        imgPosting: url,
        userImg:
            "https://akcdn.detik.net.id/visual/2019/09/25/50e93347-4111-4676-9586-3c0b39157935_169.jpeg?w=650",
        location: "${placemarks[0].subAdministrativeArea}",
        lat: "${position?.latitude}",
        long: "${position?.longitude}",
      ));

      state = ResultState.Success;
      notifyListeners();
      done();

    } catch (e) {
      state = ResultState.Error;
      notifyListeners();
      done();

      debugPrint(e.toString());
    }
  }

  Future<void> getMyLocation() async {
    var position = await _determinePosition();
    this.position = position;
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
