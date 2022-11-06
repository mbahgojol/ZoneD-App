import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoned/ui/map/maps_viewmodel.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, _) {
          return GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: viewModel.initialLocation(),
            onMapCreated: (GoogleMapController controller) {
              viewModel.controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}
