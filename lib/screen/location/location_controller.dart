import 'dart:convert';
import 'package:get/get.dart';
import 'package:taxi_drive/models/add_user_location.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_drive/res/hostting.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';

class LocationController extends GetxController {
  List<UserLocation> locations = [];
  Future<List<UserLocation>> getLocation() async {
    http.Response response = await http.get(HosttingTaxi.getUserLocation,
        headers: HosttingTaxi().getHeader());
    locations = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        locations.add(UserLocation.frommJson(element));
      }
      return locations;
    }
    return List.empty();
  }

  Future<bool> deleteLocation(int id) async {
    http.Response response = await http.delete(
        HosttingTaxi.deleteUserLoction(id),
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200 && jsonDecode(response.body)["message"]) {
      locations.removeWhere((element) => element.id == id);
      TripController tripController = Get.find();
      tripController.mark
          .removeWhere((marker) => marker.markerId.value == id.toString());
      update();
      return true;
    }
    return false;
  }
}
