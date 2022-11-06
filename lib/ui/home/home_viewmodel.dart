import 'package:flutter/material.dart';
import 'package:zoned/data/model/FeedModel.dart';

import '../../data/remote/firebase_service.dart';
import '../../utils/result_state.dart';

class HomeViewModel with ChangeNotifier {
  FirebaseService service = FirebaseService();
  ResultState state = ResultState.Initial;
  var listModel = [];

  HomeViewModel() {
    _getFeeds();
  }

  Future<void> _getFeeds() async {
    state = ResultState.Loading;
    notifyListeners();
    service.getFeeds().then((value) {
      if (value.docs.isEmpty) {
        state = ResultState.Empty;
        notifyListeners();
        return;
      }

      for (var element in value.docs) {
        listModel.add(FeedModel.fromJson(element));
      }
      state = ResultState.Loaded;
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
    });
  }
}
