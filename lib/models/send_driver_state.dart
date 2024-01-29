class SendDriverStateModel {
  late String id;
  late int? tripId;
  late String late;
  late String long;
  late String? state;
  late bool isOnline;
  late String? firstName;
  late String? fatherName;
  late String? lastName;
  late String? phone;
  late String? carNumber;
  late String? carType;
  late String? carColor;

  SendDriverStateModel({
    required this.id,
    this.tripId,
    required this.late,
    required this.long,
    this.state,
    required this.isOnline,
    this.carColor,
    this.carNumber,
    this.carType,
    this.fatherName,
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory SendDriverStateModel.fromJson(Map<String, dynamic> json) {
    return SendDriverStateModel(
      id: json['driver_id'].toString(),
      tripId: json['trip_id'],
      late: json['late'],
      long: json['long'],
      isOnline: json['is_online'],
      state: json['status'],
      carColor: json['carColor'],
      carNumber: json['carNumber'],
      carType: json['carType'],
      fatherName: json['fatherName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
    );
  }
  Map<String, dynamic> toJson() => {
        "driver_id": id,
        "late": late,
        "long": long,
        "is_online": isOnline,
      };
}
