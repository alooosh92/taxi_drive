class TripModelForSocket {
  late String id;
  late double fromLate;
  late double fromLong;
  late double toLate;
  late double toLong;
  late double price;
  late String end;
  late String start;
  late bool isAccepted;

  TripModelForSocket({
    required this.end,
    required this.fromLate,
    required this.fromLong,
    required this.id,
    required this.price,
    required this.start,
    required this.toLate,
    required this.toLong,
    required this.isAccepted,
  });

  factory TripModelForSocket.fromJson(Map<String, dynamic> json) {
    return TripModelForSocket(
      end: json["end"],
      fromLate: double.parse(json["fromLate"].toString()),
      fromLong: double.parse(json["fromLong"].toString()),
      id: json["id"],
      price: double.parse(json["price"].toString()),
      start: json["start"],
      toLate: double.parse(json["toLate"].toString()),
      toLong: double.parse(json["toLong"].toString()),
      isAccepted: json["isAccepted"],
    );
  }
}
