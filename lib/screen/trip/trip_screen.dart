import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_drive/res/hostting.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/screen/trip/widget/drawer_button.dart';
import 'package:taxi_drive/screen/trip/widget/floating_button_trip_screen.dart';
import 'package:taxi_drive/widget/drawer_home.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  void initState() {
    Geolocator.getPositionStream().listen((event) {
      TripController tripController = Get.find();
      tripController.addMyloction(event.latitude, event.longitude);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    TripController tripController = Get.find();
    final Completer<GoogleMapController> mapControllerMap =
        Completer<GoogleMapController>();
    WebSocketChannel channel = IOWebSocketChannel.connect(Hostting.websocket);
    AuthController authController = Get.find();
    var storeg = GetStorage();
    channel.sink.add('{"protocol":"json","version":1}');
    if (storeg.read("role")[0] == "Driver") {
      Timer.periodic(const Duration(seconds: 10), (timer) async {
        var myMarker = await Geolocator.getCurrentPosition();
        channel.sink.add(Hostting.sendDriverLocation(
            authController.user!.phone, myMarker.latitude, myMarker.longitude));
      });
    }
    return Scaffold(
      key: scaffoldKey,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingButtonTripScreen(
        chanal: channel,
      ),
      drawer: const DrawerHome(),
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
                                  onTap: (late) =>
                                      storeg.read("role")[0] == "User"
                                          ? controllerGet.addTripMarker(late)
                                          : null,
                                  polylines: controllerGet.polyline,
                                  onMapCreated: (controller) async {
                                    mapControllerMap.complete(controller);
                                  },
                                );
                              });
                        }),
                    DrawerButtonDef(scaffoldKey: scaffoldKey)
                  ],
                );
              });
        },
      ),
    );
  }
}
