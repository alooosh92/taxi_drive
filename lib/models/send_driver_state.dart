class SendDriverStateModel {
  late String id;
  late String late;
  late String long;
  late String? state;
  late bool isOnline;

  SendDriverStateModel({
    required this.id,
    required this.late,
    required this.long,
    this.state,
    required this.isOnline,
  });

  factory SendDriverStateModel.fromJson(Map<String, dynamic> json) {
    return SendDriverStateModel(
      id: json['driver_id'].toString(),
      late: json['late'],
      long: json['long'],
      isOnline: json['is_online'],
      state: json['status'],
    );
  }
  Map<String, dynamic> toJson() => {
        "driver_id": id,
        "late": late,
        "long": long,
        "is_online": isOnline,
      };
}
