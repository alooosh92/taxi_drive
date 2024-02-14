// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/auth/auth_controller.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';
import 'package:taxi_drive/widget/text_form_fiels_def.dart';

class ChoiseTrip extends StatelessWidget {
  const ChoiseTrip({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3.5,
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: tripController.getListLocation(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const ProgressDef();
              }
              return GetBuilder<TripController>(
                  init: tripController,
                  builder: (controller) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormFieldRadius(
                          readOnly: true,
                          label: "نقطة الانطلاق",
                          controller: tripController.start,
                          hint: "نقطة الانطلاق",
                          iconStart: Icons.location_on_outlined,
                          line: 1,
                          iconEnd: Icons.favorite,
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldRadius(
                          readOnly: true,
                          controller: tripController.end,
                          label: "نقطة الوصول",
                          hint: "نقطة الوصول",
                          iconStart: Icons.location_on_outlined,
                          line: 1,
                          iconEnd: Icons.favorite,
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("المسافة: ${tripController.masafa}"),
                              Text("السعر: ${tripController.price}"),
                              Text("الوقت المقدر: ${tripController.time}")
                            ]),
                        const SizedBox(height: 20),
                        ButtonPrimary(
                            press: () {
                              AuthController authController = Get.find();
                              Get.dialog(AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        var b =
                                            await tripController.addTripToDB();
                                        if (b == null) {
                                          Get.dialog(AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text(
                                                    'موافق',
                                                    style: TextStyle(
                                                        color:
                                                            ColorManager.red),
                                                  ))
                                            ],
                                            title: const Text('تحذير'),
                                            content: const Text(
                                                'تم حظرك من التطبيق بسبب انتهاك لشروط الاستخدام الرجاء التواصل مع الدعم الفني'),
                                          ));
                                        } else {
                                          if (b) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            tripController
                                                .changetripaccsepted(false);
                                            // buttomSheet(
                                            //     heig: 400,
                                            //     context: context,
                                            //     headerText: "البحث عن سائق",
                                            //     contener: const SaerchDriver());
                                          } else {
                                            snackbarDef("خطأ",
                                                "لا يمكن انشاء رحلتين في ان واحد");
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          }
                                        }
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  ColorManager.primary)),
                                      child: const Text(
                                        "تأكيد",
                                        style: FontManager.w500s15cW,
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  ColorManager.gray)),
                                      child: const Text(
                                        "إلغاء",
                                        style: FontManager.w500s15cW,
                                      )),
                                ],
                                title: const Text("تأكيد الطلبية"),
                                content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Divider(),
                                      Text(
                                        "المسافة المقدرة: ${tripController.masafa}",
                                        style: FontManager.w600s16cB,
                                      ),
                                      Text(
                                        "الوقت المقدرة: ${tripController.time} ",
                                        style: FontManager.w600s16cB,
                                      ),
                                      Text(
                                        "السعر المقدرة: ${tripController.price} ${authController.cityInfo!.currency}",
                                        style: FontManager.w600s16cB,
                                      ),
                                      const Divider(),
                                      const Text(
                                        "شروط الخدمة",
                                        style: FontManager.w400s16cB,
                                      ),
                                      const Text(
                                        "1- عند استلام الطلب من قبل سائق لا يمكن الغاء الطلب",
                                        style: FontManager.w400s14cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                      const Text(
                                        "2- يحق للسائقين عدم قبول الطلب ",
                                        style: FontManager.w400s14cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                      const Text(
                                        "3- عند تخلفك عن الطلب لاي سبب من الاسباب تمنح بطاقة صفراء",
                                        style: FontManager.w400s14cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                      const Text(
                                        "4- عند منحك ثلاث بطاقات صفراء يتم حظر رقمك من التطبيق لشهر كامل",
                                        style: FontManager.w400s14cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                      const Text(
                                        "5- عند منحك عشر بطاقات صفراء يتم حظر رقمك من التطبيق  نهائياً",
                                        style: FontManager.w400s14cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                      const Text(
                                        "6- يحق لسائق طلب تعرفة اضافية بحال طلب الزبون من السائق ايصاله الى مكان غير المكان المحدد من قبل الزبون عند الطلب كما يحق لسائق رفض ايصال الزبون ابعد من نقطة النهاية المحددة",
                                        style: FontManager.w400s14cB,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ]),
                              ));
                            },
                            text: "المتابعة")
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
