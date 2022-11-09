import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoned/data/model/FeedModel.dart';
import 'package:zoned/ui/map/maps_viewmodel.dart';
import 'package:zoned/utils/dummy_data.dart';

import '../../data/remote/firebase_service.dart';
import 'item_view.dart';

class HomeViewModel with ChangeNotifier {
  FirebaseService service = FirebaseService();
  Set<Circle> circles = {};
  Set<FeedModel> listIncident = {};

  Widget showList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    if ((snapshot.data?.docs.length ?? 0) > 0) {
      return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot data =
              snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
          var model = FeedModel.fromJson(data);
          listIncident.add(model);
          setCircle(context, model);
          return ItemView(model: model);
        },
      );
    } else {
      return const Center(child: Text('Not have incident'));
    }
  }

  Future<void> setCircle(BuildContext context, FeedModel model) async {
    debugPrint("lat = ${model.lat}, long = ${model.long}");
    circles.add(Circle(
        consumeTapEvents: true,
        circleId: CircleId(model.title),
        fillColor: colors[model.typeReport].withOpacity(0.3),
        strokeWidth: 0,
        center: LatLng(double.parse(model.lat), double.parse(model.long)),
        radius: 100,
        onTap: () {
          // context.read<MapsViewModel>().showIncidentDialog(model);
        }));
  }
}
