class CarModelForSocket {
  late String? name;
  late String? carNumber;
  late String? carType;
  late String? carColor;
  late String? phone;
  late String? phonetripAccepted;
  late bool? isEmpty;

  CarModelForSocket(
      {required this.carColor,
      required this.carNumber,
      required this.carType,
      required this.isEmpty,
      required this.name,
      required this.phone,
      required this.phonetripAccepted});

  factory CarModelForSocket.fromJson(Map<String, dynamic> json) {
    return CarModelForSocket(
      carColor: json["carColor"],
      carNumber: json["carNumber"],
      carType: json["carType"],
      isEmpty: json["isEmpty"],
      name: json["name"],
      phone: json["phone"],
      phonetripAccepted: json["phonetripAccepted"],
    );
  }
}
