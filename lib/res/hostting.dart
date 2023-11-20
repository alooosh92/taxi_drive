import 'package:get_storage/get_storage.dart';

class Hostting {
  var storeg = GetStorage();
  //hostting
  //static const String host = "https://taxi.arg-tr.com";
  static const String host = "https://10.0.2.2:7215";
  static const String websocket = "wss://10.0.2.2:7215/car";
  static const String mapKey = "AIzaSyCxsin6TH7ouxNCDVoRp7IJihc4JxThkG8";
  //api
  static const String api = "$host/api";
  //hrader
  Map<String, String> getHeader() {
    var token = storeg.read("token");
    if (token != null && token.toString().isNotEmpty) {
      return {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  //websocket
  static String sendDriverLocation(String phone, double late, double long) =>
      '{"arguments":["$phone",$late,$long],"invocationId":"0","target":"SendDriver","type":1}';
  static String sendTrip(String phone) =>
      '{"arguments":["$phone"],"invocationId":"0","target":"SendTrip","type":1}';
  //Auth
  static Uri register = Uri.parse("$api/Authentication/Register");
  static Uri login(String phone) =>
      Uri.parse("$api/Authentication/Login?phone=$phone");
  static Uri verify = Uri.parse("$api/Authentication/VerifyPhone");
  static Uri refreshToken = Uri.parse("$api/Authentication/RefreshToken");
  static Uri checkToken = Uri.parse("$api/Authentication/CheckToken");
  //APP
  static Uri updateProfile = Uri.parse("$api/app/UpdateUserInfo");
  static Uri showProfile = Uri.parse("$api/app/GetUserInfo");
  static Uri addTrip = Uri.parse("$api/app/AddTrip");
  static Uri addUserLocation = Uri.parse("$api/app/AddUserLocation");
  static Uri getUserLocation = Uri.parse("$api/app/GetUserLocations");
  static Uri deleteUserLoction(String id) =>
      Uri.parse("$api/app/DeleteUserLocation?locationId=$id");
  static Uri getTream(bool isPrive) =>
      Uri.parse("$api/app/GetTermsOfUseAndPrivacy?isPrivacy=$isPrive");
  static Uri acceptedTrip(String id) =>
      Uri.parse("$api/app/AcceptedTrip?id=$id");
  static Uri endedTrip(String id) => Uri.parse("$api/app/EndedTrip?id=$id");
  static Uri getAllTripForDriver(double lat, double log) =>
      Uri.parse("$api/app/GetAllTripForDriver?lat=$lat&log=$log");
  static Uri getTrip(String id) => Uri.parse("$api/app/GetTrip?id=$id");
  static Uri getAllTripForUser = Uri();
}
