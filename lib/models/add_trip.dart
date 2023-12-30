class AddTrip {
  late String fromLate;
  late String fromLong;
  late String toLate;
  late String toLong;
  late String price;

  AddTrip({
    required this.fromLate,
    required this.fromLong,
    required this.toLate,
    required this.toLong,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "fromlate": fromLate,
        "fromlong": fromLong,
        "tolate": toLate,
        "tolong": toLong,
        "price": price,
      };
}
