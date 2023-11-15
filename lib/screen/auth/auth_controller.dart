import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_drive/models/update_user.dart';
import 'package:taxi_drive/models/user_register.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_drive/models/user_verify.dart';
import 'package:taxi_drive/models/verify.dart';
import 'package:taxi_drive/res/hostting.dart';

class AuthController extends GetxController {
  UserRegister? user;

  Future<bool> register(UserRegister user) async {
    http.Response response = await http.post(Hostting.register,
        headers: Hostting().getHeader(), body: jsonEncode(user.toJson()));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> login(String phone) async {
    http.Response response =
        await http.post(Hostting.login(phone), headers: Hostting().getHeader());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> verify(Verify verify) async {
    http.Response response = await http.post(Hostting.verify,
        headers: Hostting().getHeader(), body: jsonEncode(verify.toJson()));
    if (response.statusCode == 200) {
      var storeg = GetStorage();
      var body = UserVerify.fromJson(jsonDecode(response.body));
      storeg.write("token", body.token);
      await userProfile();
      return true;
    }
    return false;
  }

  Future<UserRegister?> userProfile() async {
    http.Response response =
        await http.get(Hostting.showProfile, headers: Hostting().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      user = UserRegister.fromJson(body);
      return user;
    }
    return null;
  }

  Future<bool> updateProfile(UpdateUser userUpdate) async {
    http.Response response = await http.post(Hostting.updateProfile,
        headers: Hostting().getHeader(), body: jsonEncode(userUpdate.toJson()));
    if (response.statusCode == 200) {
      var body = UserRegister.fromJson(jsonDecode(response.body));
      user = body;
      return true;
    }
    return false;
  }

  Future<bool> checkToken() async {
    http.Response response =
        await http.get(Hostting.checkToken, headers: Hostting().getHeader());
    if (response.statusCode == 200) {
      await userProfile();
      return true;
    }
    return false;
  }
}
