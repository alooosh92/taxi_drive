import 'package:get/get.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';

class BindingDef implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripController(), fenix: true);
  }
}
