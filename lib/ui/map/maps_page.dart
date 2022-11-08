import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoned/ui/feeds/widget/item_incident.dart';
import 'package:zoned/ui/map/maps_viewmodel.dart';
import 'package:zoned/utils/dummy_data.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: viewModel.initialLocation(),
                onMapCreated: (GoogleMapController controller) {
                  viewModel.controller.complete(controller);
                },
                circles: {
                  Circle(
                    circleId: const CircleId(""),
                    center: LatLng(viewModel.position?.latitude??0, viewModel.position?.longitude??0),
                    radius: 100,
                    fillColor: Colors.blue.shade100.withOpacity(0.5),
                    strokeColor:  Colors.blue.shade100.withOpacity(0.1),
                  )
                },
              ),
              Card(
                  margin: const EdgeInsets.all(2),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: names.length,
                        itemBuilder: (context, posisi) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: ItemIncident(
                                name: names[posisi], myColor: colors[posisi]),
                          );
                        }),
                  ))
            ],
          );
        },
      ),
    );
  }
}
