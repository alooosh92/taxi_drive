import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/screen/location/location_controller.dart';
import 'package:taxi_drive/widget/progress_def.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';

class LoctionScreen extends StatelessWidget {
  const LoctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("عناويني")),
      body: FutureBuilder(
        future: locationController.getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProgressDef();
          }
          return GetBuilder<LocationController>(
              init: locationController,
              builder: (constroller) {
                return ListView.builder(
                    itemCount: locationController.locations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Column(children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: ColorManager.primary,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                              child: Center(
                                child: Text(constroller.locations[index].name),
                              ),
                            ),
                            Row(
                              children: [
                                const Text("حط العرض: "),
                                Text(constroller.locations[index].lat
                                    .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("حط الطول: "),
                                Text(constroller.locations[index].long
                                    .toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      var b = await locationController
                                          .deleteLocation(
                                              snapshot.data[index].id);
                                      if (b) {
                                        snackbarDef("ملاحظة",
                                            "تم حذف الموقع من المفضلة");
                                      } else {
                                        snackbarDef("تحذير",
                                            "هناك خطأ ما الرجاء التواصل مع المسؤول");
                                      }
                                    },
                                    child: const Text("حذف")),
                              ],
                            ),
                          ]),
                        ),
                      );
                    });
              });
        },
      ),
    );
  }
}
