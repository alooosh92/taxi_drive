import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_drive/models/show_trip.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import '../../widget/drawer_home.dart';

class UserTrip extends StatefulWidget {
  const UserTrip({super.key});

  @override
  State<UserTrip> createState() => _UserTripState();
}

class _UserTripState extends State<UserTrip> {
  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined))
        ],
        title: const Text(
          "رحلاتي",
          style: FontManager.w600s24cB,
        ),
        centerTitle: true,
      ),
      drawer: DrawerHome(),
      body: FutureBuilder<List<ShowTrip>>(
        future: tripController.getUserTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProgressDef();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return FutureBuilder<Map<String, String?>>(
                  future: getAdress(
                      snapshot.data![index].fromLate,
                      snapshot.data![index].fromLong,
                      snapshot.data![index].toLate,
                      snapshot.data![index].toLong),
                  builder: (context, address) {
                    if (address.connectionState == ConnectionState.waiting) {
                      return const ProgressDef();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 180,

                        //230
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              side: BorderSide(
                                  color: ColorManager.primary, width: 1.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      ' كود الرحلة :',
                                      style: FontManager.w500s17cB,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      snapshot.data![index].id.toString(),
                                      style: FontManager.w500s17cB,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      ' من : ',
                                      style: FontManager.w500s17cB,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(address.data!['from']!),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'الى : ',
                                      style: FontManager.w500s17cB,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(address.data!['to']!)
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'تاريخ الرحلة : ',
                                      style: FontManager.w500s17cB,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat('yyyy/MM/dd - hh:mm').format(
                                          snapshot.data![index].created),
                                      style: FontManager.w500s17cB,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'المبلغ ',
                                      style: FontManager.w400s17cP,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      snapshot.data![index].price
                                          .toInt()
                                          .toString(),
                                      style: FontManager.w500s17cB,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // const RouteButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}

Future<Map<String, String?>> getAdress(
    double frla, double frlo, double tola, double tolo) async {
  try {
    List<Placemark> from = await placemarkFromCoordinates(frla, frlo);
    List<Placemark> to = await placemarkFromCoordinates(tola, tolo);
    return {
      'from': from[0].street.toString(),
      'to': to[0].street.toString(),
    };
  } catch (erorr) {
    return {'from': '', 'to': ''};
  }
}
