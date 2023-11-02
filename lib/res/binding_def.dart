import 'package:get/get.dart';
import 'package:taxi_drive/screen/map/map_controller.dart';

class BindingDef implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController(), fenix: true);
  }
}
