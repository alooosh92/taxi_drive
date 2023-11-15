import 'package:get_storage/get_storage.dart';

class Hostting {
  var storeg = GetStorage();
  //hostting
  static const String host = "https://taxi.arg-tr.com";
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
        'Authorization': 'Bearer $token',
      };
    }
    return {
      'Accept': 'application/json',
    };
  }

  //websocket
  static String sendLocation(
          String name, double late, double long, bool isCar, bool isFree) =>
      '{"arguments":["$name",$late,$long,$isCar,$isFree],"invocationId":"0","target":"send","type":1}';
  //api
  static Uri register = Uri.parse("$api/register");
  static Uri login = Uri.parse("$api/login");
  static Uri verify = Uri.parse("$api/verifyRegister");
  static Uri showProfile = Uri.parse("$api/show");
  static Uri updateProfile = Uri.parse("$api/updateProfile");
  static Uri support = Uri.parse("$api/support");
}
