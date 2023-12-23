import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/models/show_trip.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/progress_def.dart';

class UserTrip extends StatelessWidget {
  const UserTrip({super.key});

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("رحلاتي")),
      body: FutureBuilder<List<ShowTrip>>(
          future: tripController.getUserTrips(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressDef();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      children: [Text(snapshot.data![index].id)],
                    ),
                  );
                });
          }),
    );
  }
}
