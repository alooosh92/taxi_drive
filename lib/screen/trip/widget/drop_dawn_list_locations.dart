import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_drive/screen/trip/trip_controller.dart';

class DropDawnListLocations extends StatelessWidget {
  const DropDawnListLocations({super.key, required this.isStart});
  final bool isStart;
  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    List<DropdownMenuItem<int?>> list = isStart
        ? tripController.listLoction
        : tripController.listLoction
            .where((element) => element.value != null)
            .toList();

    return DropdownButtonFormField<int?>(
      value: isStart
          ? tripController.textStartPostion
          : tripController.textEndPostion,
      borderRadius: BorderRadius.circular(20),
      decoration: InputDecoration(
        label:
            isStart ? const Text("نقطة الانطلاق") : const Text("نقطة الوصول"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: const Icon(Icons.location_on_outlined),
        isDense: true,
      ),
      items: list,
      onChanged: (val) {
        isStart
            ? tripController.textStartPostion = val
            : tripController.textEndPostion = val;
      },
    );
  }
}
