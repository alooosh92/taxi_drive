import 'package:get_storage/get_storage.dart';

class Hostting {
  var storeg = GetStorage();
  //hostting
  static const String host = "https://taxi.arg-tr.com";
  static const String api = "$host/api";

  //hrader
  Map<String, String> getHeader() {
    var token = storeg.read("token");
    if (token != null && token.toString().isNotEmpty) {
      return {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return {
      'Accept': 'application/json',
    };
  }

  //api
  static Uri register = Uri.parse("$api/register");
  static Uri login = Uri.parse("$api/login");
  static Uri verify = Uri.parse("$api/verifyRegister");
  static Uri showProfile = Uri.parse("$api/show");
  static Uri updateProfile = Uri.parse("$api/updateProfile");
  static Uri support = Uri.parse("$api/support");
}
