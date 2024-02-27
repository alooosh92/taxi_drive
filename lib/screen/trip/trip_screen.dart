import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/models/send_driver_state.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/hostting.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/screen/trip/widget/drawer_button.dart';
import 'package:taxi_drive/screen/trip/widget/floating_button_trip_screen.dart';
import 'package:taxi_drive/widget/drawer_home.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  WebSocketChannel channel = IOWebSocketChannel.connect(HosttingTaxi.websocket);
  @override
  void initState() {
    channel.sink.add(HosttingTaxi.openSocket);
    Geolocator.getPositionStream().listen((event) {
      TripController tripController = Get.find();
      tripController.addMyloction(event.latitude, event.longitude);
    });
    FirebaseMessaging.onMessage.listen((event) {
      Get.snackbar(event.notification!.title.toString(),
          event.notification!.body.toString(),
          backgroundColor: ColorManager.black, colorText: ColorManager.white);
    });
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    TripController tripController = Get.find();
    final Completer<GoogleMapController> mapControllerMap =
        Completer<GoogleMapController>();
    var storeg = GetStorage();

    tripController.context = context;
    if (storeg.read("role") == "driver") {
      var storeg = GetStorage();
      tripController.getTripForDriver();
      Timer.run(() async {
        if (channel.closeCode != null) {
          channel.sink.add(HosttingTaxi.openSocket);
        }
        var myMarker = await Geolocator.getCurrentPosition();
        SendDriverStateModel dr = SendDriverStateModel(
            id: storeg.read('id').toString(),
            late: myMarker.latitude.toString(),
            long: myMarker.longitude.toString(),
            isOnline: true);
        await http.post(HosttingTaxi.sendDriverState,
            headers: HosttingTaxi().getHeader(), body: jsonEncode(dr.toJson()));
      });
      Timer.periodic(const Duration(seconds: 30), (timer) async {
        if (channel.closeCode != null) {
          channel.sink.add(HosttingTaxi.openSocket);
        }
        var myMarker = await Geolocator.getCurrentPosition();
        SendDriverStateModel dr = SendDriverStateModel(
            id: storeg.read('id').toString(),
            late: myMarker.latitude.toString(),
            long: myMarker.longitude.toString(),
            isOnline: true);
        http.post(HosttingTaxi.sendDriverState,
            headers: HosttingTaxi().getHeader(), body: jsonEncode(dr.toJson()));
      });
    }
    return Scaffold(
      key: scaffoldKey,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: const FloatingButtonTripScreen(),
      drawer: DrawerHome(),
      body: FutureBuilder(
        future: tripController.getPosition(),
        builder: (BuildContext context, AsyncSnapshot camPostine) {
          if (camPostine.connectionState == ConnectionState.waiting) {
            return const ProgressDef();
          }
          return GetBuilder<TripController>(
            init: tripController,
            builder: (controllerGet) {
              return Stack(
                children: [
                  StreamBuilder<Position>(
                      stream: Geolocator.getPositionStream(),
                      builder: (context, myMarker) {
                        return StreamBuilder(
                            stream: channel.stream,
                            builder: (context, mapMarker) {
                              if (mapMarker.hasData) {
                                controllerGet
                                    .addMarkerFromSocket(mapMarker.data);
                              }
                              return GoogleMap(
                                myLocationButtonEnabled: true,
                                myLocationEnabled: false,
                                zoomControlsEnabled: false,
                                initialCameraPosition: controllerGet.cam!,
                                markers: controllerGet.mark,
                                onTap: (late) => storeg.read("role") == "user"
                                    ? controllerGet.addTripMarker(late)
                                    : null,
                                polylines: controllerGet.polyline,
                                onMapCreated: (controller) async {
                                  mapControllerMap.complete(controller);
                                },
                              );
                            });
                      }),
                  DrawerButtonDef(scaffoldKey: scaffoldKey),
                  Visibility(
                    visible: storeg.read('role') == 'driver',
                    child: Positioned(
                      top: 27,
                      right: 10,
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.white),
                          child: Text(
                            tripController.driverBalance != null
                                ? "رصيدك: ${tripController.driverBalance}"
                                : "",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          )),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
