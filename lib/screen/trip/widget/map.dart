import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/widget/progress_def.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: FontManager.w400s20cB,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: ColorManager.gray,
              label: const Text("نقطة الانطلاق"),
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: ColorManager.brown,
              label: const Text("نقطة الوصول"),
            ),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: ColorManager.primary,
              child: const Icon(
                Icons.add,
                color: ColorManager.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Position>(
        future: Geolocator.getCurrentPosition(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const ProgressDef();
          }
          return GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(snapShot.data!.latitude, snapShot.data!.longitude),
              zoom: 12,
            ),
          );
        },
      ),
    );
  }
}
