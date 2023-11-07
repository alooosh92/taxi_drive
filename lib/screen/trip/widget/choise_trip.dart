import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/progress_def.dart';
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
                        ),
                        // const DropDawnListLocations(isStart: true),
                        const SizedBox(height: 10),
                        TextFormFieldRadius(
                          readOnly: true,
                          controller: tripController.end,
                          label: "نقطة الوصول",
                          hint: "نقطة الوصول",
                          iconStart: Icons.location_on_outlined,
                          line: 1,
                        ),
                        // const DropDawnListLocations(isStart: false),
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
                              Get.dialog(AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  ColorManager.primary)),
                                      child: const Text(
                                        "تأكيد",
                                        style: FontManager.w500s15cW,
                                      )),
                                  ElevatedButton(
                                      onPressed: () {},
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
                                content: Expanded(
                                  child: Column(
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
                                          "الوقت المقدرة: ${tripController.time}",
                                          style: FontManager.w600s16cB,
                                        ),
                                        Text(
                                          "السعر المقدرة: ${tripController.price}",
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
                                ),
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
