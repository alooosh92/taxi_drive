import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';

SnackbarController snackbarDef(String title, String message) {
  return Get.snackbar(title, message,
      backgroundColor: title == "خطأ" ? ColorManager.red : ColorManager.primary,
      colorText: title == "خطأ" ? ColorManager.white : ColorManager.black,
      animationDuration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM);
}
