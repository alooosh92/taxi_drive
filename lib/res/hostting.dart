import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class HosttingTaxi {
  var storeg = GetStorage();
  static const String host = "https://srv451438.hstgr.cloud";
  static const String websocket = "ws://srv451438.hstgr.cloud:8443/app/myKey";
  static const String mapKey = "AIzaSyCxsin6TH7ouxNCDVoRp7IJihc4JxThkG8";
  static dynamic openSocket = jsonEncode({
    "event": "pusher:subscribe",
    "data": {"channel": "public-channel"}
  });
  static const String api = "$host/api";
  //hrader
  Map<String, String> getHeader() {
    var token = storeg.read("token");
    if (token != null && token.toString().isNotEmpty) {
      return {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return {
      'Content-Type': 'application/json',
    };
  }

  //API
  static Uri sendDriverState = Uri.parse("$api/ChangeStateDriver");
  static Uri register = Uri.parse("$api/Register");
  static Uri login = Uri.parse("$api/Login");
  static Uri verify = Uri.parse("$api/VerifyPhone");
  static Uri addTrip = Uri.parse("$api/Addtrip");
  static Uri updateProfile = Uri.parse("$api/updateProfile");
  static Uri showProfile = Uri.parse("$api/showProfile");
  static Uri addUserLocation = Uri.parse("$api/AddUserLocation");
  static Uri getUserLocation = Uri.parse("$api/GetUserLocations");
  static Uri sendMessage = Uri.parse("$api/AddConnectWithUs");
  static Uri getUserTrip = Uri.parse("$api/GetUserTrip");
  static Uri getRegion = Uri.parse("$api/GetAllCitiesInfo");
  static Uri getLastTrip = Uri.parse("$api/getLastTrip");
  static Uri getVersion = Uri.parse("$api/getVersionApp");
  static Uri getTrip(int id) => Uri.parse("$api/GetTrip?trip_id=$id");
  static Uri getDriver(int? id) => Uri.parse("$api/GetDriver?driver_id=$id");
  static Uri rating(double route, int idTrip, int idDriver) => Uri.parse(
      "$api/Rating?driver_id=$idDriver&rating=$route&trip_id=$idTrip");
  static Uri getMyCity(String region) =>
      Uri.parse("$api/GetCityInfo?city=$region");
  static Uri deleteUserLoction(int id) =>
      Uri.parse("$api/DeleteUserLocation?location_id=$id");
  static Uri getTream(int isPrive) =>
      Uri.parse("$api/GetTermsOfUseAndPrivacy?isPrivacy=$isPrive");
  static Uri acceptedTrip(int tripId, int driverId) =>
      Uri.parse("$api/AcceptedTrip?driver_id=$driverId&trip_id=$tripId");
  static Uri endedTrip(int id) => Uri.parse("$api/EndedTrip?trip_id=$id");
  static Uri getAllTripForDriver(double lat, double log) =>
      Uri.parse("$api/GetAllTrip?lat=$lat&long=$log");
  static Uri deleteTrip(int id) => Uri.parse("$api/DeleteTrip?trip_id=$id");
  static Uri getDriverEndLessTrip(int id) =>
      Uri.parse('$api/getDriverEndlessTrip?driver_id=$id');
  static Uri getUserEndLessTrip = Uri.parse('$api/getUserEndlessTrip');
}
