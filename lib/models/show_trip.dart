class ShowTrip {
  late int id;
  late double fromLate;
  late double fromLong;
  late double toLate;
  late double toLong;
  late String userName;
  late String phone;
  late double? userRating;
  late double price;
  late DateTime created;
  late DateTime? accepted;
  late DateTime? ended;
  late String? firtName;
  late String? lastName;
  late String? carNumber;
  late String? carType;
  late String? carColor;

  ShowTrip({
    required this.id,
    required this.fromLong,
    required this.fromLate,
    required this.toLate,
    required this.toLong,
    required this.userName,
    required this.phone,
    required this.userRating,
    required this.price,
    required this.created,
    required this.accepted,
    required this.ended,
    required this.firtName,
    required this.lastName,
    required this.carNumber,
    required this.carType,
    required this.carColor,
  });

  factory ShowTrip.fromJson(Map<String, dynamic> json) {
    return ShowTrip(
      id: json["id"],
      fromLong: double.parse(json["fromLong"].toString()),
      fromLate: double.parse(json["fromLate"].toString()),
      toLate: double.parse(json["toLate"].toString()),
      toLong: double.parse(json["toLong"].toString()),
      userName: json["userName"],
      phone: json["phone"],
      userRating: json["userRating"] != null
          ? double.parse(json["userRating"].toString())
          : null,
      price: double.parse(json["price"].toString()),
      created: DateTime.parse(json["created"].toString()),
      accepted: json["accepted"] == null
          ? null
          : DateTime.parse(json["accepted"].toString()),
      ended: json["ended"] == null
          ? null
          : DateTime.parse(json["ended"].toString()),
      firtName: json["firtName"],
      lastName: json["lastName"],
      carNumber: json["carNumber"],
      carType: json["carType"],
      carColor: json["carColor"],
    );
  }
}
