import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_drive/models/term.dart';
import 'package:taxi_drive/res/hostting.dart';

class AppInfoController extends GetxController {
  Future<List<TreamModel>> getTream(int isPrive) async {
    http.Response response = await http.get(HosttingTaxi.getTream(isPrive));
    List<TreamModel> list = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var element in body) {
        list.add(TreamModel.fromJson(element));
      }
    }
    return list;
  }
}
