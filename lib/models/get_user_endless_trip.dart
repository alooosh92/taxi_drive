class GetUserEndLessTrip {
  late int id;
  late double fromLate;
  late double fromLong;
  late double toLate;
  late double toLong;
  late double price;
  late String phone;
  late String firstName;
  late String lastName;
  late String phoneDriver;
  late String carNumber;
  late String carType;
  late String carColore;

  GetUserEndLessTrip({
    required this.carColore,
    required this.carNumber,
    required this.carType,
    required this.firstName,
    required this.fromLate,
    required this.fromLong,
    required this.id,
    required this.lastName,
    required this.phoneDriver,
    required this.price,
    required this.toLate,
    required this.toLong,
  });

  factory GetUserEndLessTrip.fromJson(Map<String, dynamic> json) {
    return GetUserEndLessTrip(
      carColore: json['carColor'],
      carNumber: json['carNumber'],
      carType: json['carType'],
      firstName: json['firstName'],
      fromLate: double.parse(json['fromLate'].toString()),
      fromLong: double.parse(json['fromLong'].toString()),
      id: json['id'],
      lastName: json['lastName'],
      phoneDriver: json['phone_driver'],
      price: double.parse(json['price'].toString()),
      toLate: double.parse(json['toLate'].toString()),
      toLong: double.parse(json['toLong'].toString()),
    );
  }
}
