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
  static Uri deleteUserLoction(int id) =>
      Uri.parse("$api/DeleteUserLocation?location_id=$id");
  static Uri getTream(int isPrive) =>
      Uri.parse("$api/GetTermsOfUseAndPrivacy?isPrivacy=$isPrive");
  static Uri acceptedTrip(int tripId, int driverId) =>
      Uri.parse("$api/AcceptedTrip?driver_id=$driverId&trip_id=$tripId");
  static Uri endedTrip(int id) => Uri.parse("$api/EndedTrip?trip_id=$id");
  static Uri getAllTripForDriver(double lat, double log) =>
      Uri.parse("$api/GetAllTrip?lat=$lat&long=$log");
}


// class Hostting {
//   static const String host = "https://taxidrivertest-001-site1.ctempurl.com";
//   static const String api = "$host/api";
//   static Uri refreshToken = Uri.parse("$api/Authentication/RefreshToken");
//   static Uri checkToken = Uri.parse("$api/Authentication/CheckToken");
// static String acceptTrip(String id) =>
//     '{"arguments":["$id"],"target":"AcceptTrip","type":1}';
// static Uri getAllTripForDriver(double lat, double log) =>
//     Uri.parse("$api/app/GetAllTripForDriver?lat=$lat&log=$log");
// static Uri endedTrip(String id) => Uri.parse("$api/app/EndedTrip?id=$id");
// static Uri acceptedTrip(String id) =>
//     Uri.parse("$api/app/AcceptedTrip?id=$id");
// var storeg = GetStorage();
//static Uri getTrip(String id) => Uri.parse("$api/app/GetTrip?id=$id");
// static Uri getAllTripForUser = Uri();
// static String sendDriverLocation(String phone, double late, double long) =>
//     '{"arguments":["$phone",$late,$long],"target":"SendDriver","type":1}';
// static String sendTrip(String phone) =>
//     '{"arguments":["$phone"],"target":"SendTrip","type":1}';
//static const String websocket =
//  "wss://taxidrivertest-001-site1.ctempurl.com/car";
//static const dynamic openSocket = '{"protocol":"json","version":1}';
//static Uri getUserTrip = Uri.parse("$api/app/GetAllTrip");
//static const String mapKey = "AIzaSyCxsin6TH7ouxNCDVoRp7IJihc4JxThkG8";
// Map<String, String> getHeader() {
//   var token = storeg.read("token");
//   if (token != null && token.toString().isNotEmpty) {
//     return {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//   }
//   return {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//   };
// }
// static const String host = "https://10.0.2.2:7215";
// static const String websocket = "wss://10.0.2.2:7215/car";
//Auth
// static Uri register = Uri.parse("$api/Authentication/Register");
// static Uri login(String phone) =>
//     Uri.parse("$api/Authentication/Login?phone=$phone");
// static Uri verify = Uri.parse("$api/Authentication/VerifyPhone");
//APP
//static Uri updateProfile = Uri.parse("$api/app/UpdateUserInfo");
//static Uri showProfile = Uri.parse("$api/app/GetUserInfo");
//static Uri addTrip = Uri.parse("$api/app/AddTrip");
//static Uri addUserLocation = Uri.parse("$api/app/AddUserLocation");
//static Uri getUserLocation = Uri.parse("$api/app/GetUserLocations");
//static Uri deleteUserLoction(String id) =>
//    Uri.parse("$api/app/DeleteUserLocation?locationId=$id");
//static Uri getTream(bool isPrive) =>
//   Uri.parse("$api/app/GetTermsOfUseAndPrivacy?isPrivacy=$isPrive");
//}
