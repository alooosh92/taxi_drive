import 'package:get/get.dart';
import 'package:taxi_drive/screen/app_info/app_info_controller.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/location/location_controller.dart';
import 'package:taxi_drive/screen/make_a_complaint/make_a_complaint_controller.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';

class BindingDef implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => LocationController(), fenix: true);
    Get.lazyPut(() => AppInfoController(), fenix: true);
    Get.lazyPut(() => MakeAComplaintController(), fenix: true);
  }
}
