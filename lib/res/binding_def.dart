import 'package:get/get.dart';
import 'package:taxi_drive/controller.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';

class BindingDef implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => Controller(), fenix: true);
  }
}
