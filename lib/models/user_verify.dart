class UserVerify {
  late int id;
  late bool isAuthanticated;
  late String? name;
  late String? email;
  late String? roles;
  late String? token;
  late String? phone;
  late String cityAddress;
  UserVerify(
      {required this.email,
      required this.isAuthanticated,
      required this.name,
      required this.phone,
      required this.roles,
      required this.token,
      required this.id,
      required this.cityAddress});

  factory UserVerify.fromJson(Map<String, dynamic> json) {
    return UserVerify(
      id: json["id"],
      email: json["email"],
      isAuthanticated: json["isAuthanticated"],
      phone: json["phone"],
      name: json["name"],
      roles: json["roles"],
      token: json["token"],
      cityAddress: json['city_address'],
    );
  }
}
