import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/res/color_manager.dart';
import 'package:taxi_drive/res/font_manager.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';
import 'package:taxi_drive/widget/button_primary.dart';
import 'package:taxi_drive/widget/snackbar_def.dart';

class RouteSheet extends StatefulWidget {
  const RouteSheet({super.key, required this.driverId, required this.tripId});
  final String driverId;
  final String tripId;
  @override
  State<RouteSheet> createState() => _RouteSheetState();
}

class _RouteSheetState extends State<RouteSheet> {
  List<double> ratings = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Text(
              ' نشكركم على اختيار تكسي',
              style: FontManager.w700s25cp,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('قيم أداء السائق في اخر رحلة'),
            const SizedBox(
              height: 15,
            ),
            RatingBar.builder(
                itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (val1) {
                  setState(() {
                    ratings.add(val1);
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text('قيم نظافة المركبة في اخر رحلة'),
            const SizedBox(
              height: 15,
            ),
            RatingBar.builder(
                itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (val2) {
                  setState(() {
                    ratings.add(val2);
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            ButtonPrimary(
              press: () async {
                double averageRating = ratings.isEmpty
                    ? 0
                    : ratings.reduce((val1, val2) => val1 + val2) /
                        ratings.length;
                TripController tripController = Get.find();
                var b = await tripController.sendRouteTrip(averageRating,
                    int.parse(widget.tripId), int.parse(widget.driverId));
                if (b) {
                  snackbarDef('ملاحظة', 'شكرا لك لتقييم اداء السائق');
                } else {
                  snackbarDef('تحذير', 'شكرا لك لتقييم اداء السائق');
                }
                setState(() {});
              },
              text: 'ارسل تقييمك الآن',
            ),
          ],
        ),
      ),
    );
  }
}
