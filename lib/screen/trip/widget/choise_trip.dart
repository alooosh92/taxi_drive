import 'package:flutter/cupertino.dart';
import 'package:taxi_drive/widget/button_primary.dart';

class ChoiseTrip extends StatelessWidget {
  const ChoiseTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3.5,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextFormFieldRadius(
            //   controller: ,
            //   hint: "موقع الانطلاق",
            //   iconEnd: Icons.location_searching_sharp,
            //   topPadding: 20,
            //   radius: 10,
            // ),
            // TextFormFieldRadius(
            //   controller: ,
            //   hint: "موقع الوصول",
            //   iconEnd: Icons.location_searching_sharp,
            //   topPadding: 20,
            //   radius: 10,
            // ),
            ButtonPrimary(press: () {}, text: "المتابعة")
          ],
        ),
      ),
    );
  }
}
