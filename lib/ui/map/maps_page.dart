import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoned/ui/feeds/widget/item_incident.dart';
import 'package:zoned/ui/home/home_viewmodel.dart';
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
                initialCameraPosition: CameraPosition(
                  target: LatLng(viewModel.latitude, viewModel.longitude),
                  zoom: 16.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  viewModel.controller.complete(controller);
                },
                circles: context.read<HomeViewModel>().circles,
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
                  )),
              const Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Card(
                    child: Text('testing aza'),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
