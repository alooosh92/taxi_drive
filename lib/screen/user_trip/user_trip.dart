import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/models/show_trip.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/progress_def.dart';

import '../../widget/drawer_home.dart';

class UserTrip extends StatelessWidget {
  const UserTrip({super.key});

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_forward_ios_outlined))],
        title: const Text("رحلاتي", style: FontManager.w600s24cB,), centerTitle: true,
      ),
      drawer: const DrawerHome(),
      body:
      FutureBuilder<List<ShowTrip>>(
          future: tripController.getUserTrips(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressDef();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 170,
                      child:  Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50),
                            ),
                            side: BorderSide(color: ColorManager.primary, width: 1.0)
                        ),

                        child:
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(children: [
                            Row(
                              children: [
                                Text(' كود الرحلة :',style: FontManager.w500s17cB,),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].id.toString(),style: FontManager.w500s17cB, ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(' من : ',style: FontManager.w500s17cB,),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].fromLate.toString(),style: FontManager.w500s17cB,),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].fromLong.toString(),style: FontManager.w500s17cB,),
                              ],
                            ),
                            Row(
                              children: [
                                Text('الى : ',style: FontManager.w500s17cB,),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].toLate.toString(),style: FontManager.w500s17cB,),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].toLong.toString(),style: FontManager.w500s17cB,),
                              ],
                            ),
                            Row(
                              children: [
                                Text('تاريخ الرحلة : ',style: FontManager.w500s17cB,),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].created.toString(),style: FontManager.w500s17cB,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('المبلغ ',  style: FontManager.w400s17cP, ),
                                SizedBox(width: 5,),
                                Text(snapshot.data![index].price.toString(),style: FontManager.w500s17cB,),
                              ],
                            ),

                          ]),

                        ),),
                    ),
                  );
                });


          }
          ),

    );
  }
}
