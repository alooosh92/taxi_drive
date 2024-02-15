class GetDriverEndLessTrip {
  late int tripId;
  late int userId;
  late double fromLate;
  late double fromLong;
  late double toLate;
  late double toLong;
  late double price;
  late String phone;
  late String username;
  late String state;

  GetDriverEndLessTrip({
    required this.fromLate,
    required this.fromLong,
    required this.phone,
    required this.price,
    required this.state,
    required this.toLate,
    required this.toLong,
    required this.tripId,
    required this.userId,
    required this.username,
  });

  factory GetDriverEndLessTrip.fromJson(Map<String, dynamic> json) {
    return GetDriverEndLessTrip(
      fromLate: double.parse(json['fromLate'].toString()),
      fromLong: double.parse(json['fromLong'].toString()),
      phone: json['phone'],
      price: double.parse(json['price'].toString()),
      state: json['status'],
      toLate: double.parse(json['toLate'].toString()),
      toLong: double.parse(json['toLong'].toString()),
      tripId: json['trip_id'],
      userId: json['user_id'],
      username: json['userName'],
    );
  }
}
