class TripModelForSocket {
  late int id;
  late int userId;
  late double fromLate;
  late double fromLong;
  late double toLate;
  late double toLong;
  late double price;
  late String status;
  late DateTime created;

  TripModelForSocket(
      {required this.fromLate,
      required this.fromLong,
      required this.id,
      required this.price,
      required this.toLate,
      required this.toLong,
      required this.created,
      required this.status,
      required this.userId});

  factory TripModelForSocket.fromJson(Map<String, dynamic> json) {
    return TripModelForSocket(
      created: DateTime.parse(json['created'].toString()),
      fromLate: double.parse(json['fromLate'].toString()),
      fromLong: double.parse(json['fromLong'].toString()),
      id: json['trip_id'],
      price: double.parse(json['price'].toString()),
      status: json['status'],
      toLate: double.parse(json['toLate'].toString()),
      toLong: double.parse(json['toLong'].toString()),
      userId: json['user_id'],
    );
  }
}
