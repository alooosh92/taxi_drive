import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';

SnackbarController snackbarDef(String title, String message) {
  return Get.snackbar(title, message,
      backgroundColor: ColorManager.primary,
      colorText: ColorManager.black,
      animationDuration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM);
}
