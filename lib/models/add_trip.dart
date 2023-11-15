class AddTrip {
  late double fromLate;
  late double fromLong;
  late double toLate;
  late double toLong;
  late double price;

  AddTrip({
    required this.fromLate,
    required this.fromLong,
    required this.toLate,
    required this.toLong,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "fromLate": fromLate,
        "fromLong": fromLong,
        "toLate": toLate,
        "toLong": toLong,
        "price": price,
      };
}
