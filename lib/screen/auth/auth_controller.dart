import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_drive/models/city_info.dart';
import 'package:taxi_drive/models/update_user.dart';
import 'package:taxi_drive/models/user_register.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_drive/models/user_verify.dart';
import 'package:taxi_drive/models/verify.dart';
import 'package:taxi_drive/res/hostting.dart';

class AuthController extends GetxController {
  UserRegister? user;
  CityInfo? cityInfo;
  Future<bool> register(UserRegister user) async {
    if (user.phone.contains('+') && user.phone[0] == '+') {
      user.phone = user.phone.substring(1);
    } else {
      if (user.phone.substring(0, 2) == '00') {
        user.phone = user.phone.substring(2);
      }
    }
    user.phone = '+${user.phone}';
    http.Response response =
        await http.post(HosttingTaxi.register, body: user.toJson());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> login(String phone) async {
    if (phone.contains('+') && phone[0] == '+') {
      phone = phone.substring(1);
    } else {
      if (phone.substring(0, 2) == '00') {
        phone = phone.substring(2);
      }
    }
    http.Response response =
        await http.post(HosttingTaxi.login, body: {'phone': '+$phone'});
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> verify(Verify verify) async {
    if (verify.phone.contains('+') && verify.phone[0] == '+') {
      verify.phone = verify.phone.substring(1);
    } else {
      if (verify.phone.substring(0, 2) == '00') {
        verify.phone = verify.phone.substring(2);
      }
    }
    verify.phone = '+${verify.phone}';
    http.Response response =
        await http.post(HosttingTaxi.verify, body: verify.toJson());
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["isAuthanticated"] == true) {
      var storeg = GetStorage();
      var body = UserVerify.fromJson(jsonDecode(response.body));
      storeg.write("id", body.id);
      storeg.write("token", body.token);
      storeg.write("role", body.roles);
      storeg.write('phone', body.phone);
      storeg.write('region', body.cityAddress);
      await userProfile();
      return true;
    }
    return false;
  }

  Future<UserRegister?> userProfile() async {
    http.Response response = await http.get(HosttingTaxi.showProfile,
        headers: HosttingTaxi().getHeader());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      user = UserRegister.fromJson(body);
      return user;
    }
    return null;
  }

  Future<bool> updateProfile(UpdateUser userUpdate) async {
    if (userUpdate.phone.contains('+') && userUpdate.phone[0] == '+') {
      userUpdate.phone = userUpdate.phone.substring(1);
    } else {
      if (userUpdate.phone.substring(0, 2) == '00') {
        userUpdate.phone = userUpdate.phone.substring(2);
      }
    }
    userUpdate.phone = '+${userUpdate.phone}';
    http.Response response = await http.post(HosttingTaxi.updateProfile,
        headers: HosttingTaxi().getHeader(),
        body: jsonEncode(userUpdate.toJson()));
    if (response.statusCode == 200) {
      var body = UserRegister.fromJson(jsonDecode(response.body));
      user = body;
      return true;
    }
    return false;
  }

  Future<bool> checkToken() async {
    var storeg = GetStorage();
    String? region = storeg.read('region');
    if (region != null) {
      http.Response response = await http.post(HosttingTaxi.getMyCity(region),
          headers: HosttingTaxi().getHeader());
      if (response.statusCode == 200) {
        cityInfo = CityInfo.fromJson(jsonDecode(response.body)[0]);
        return true;
      }
    }
    return false;
  }

  Future<List<DropdownMenuItem<String>>> getRegion() async {
    http.Response response = await http.get(HosttingTaxi.getRegion,
        headers: HosttingTaxi().getHeader());
    List<DropdownMenuItem<String>> list = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        list.add(DropdownMenuItem<String>(
          value: element['city'],
          child: Text(element['city']),
        ));
      }
    }
    return list;
  }

  Future<String?> getVersion() async {
    http.Response response = await http.get(HosttingTaxi.getVersion);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['version'].toString();
    }
    return null;
  }
}
