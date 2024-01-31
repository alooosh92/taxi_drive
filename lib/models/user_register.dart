class UserRegister {
  late String name;
  late String phone;
  late String? email;
  late String? region;

  UserRegister(
      {required this.name, required this.phone, this.email, this.region});

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        region: json['city_address']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "city address": region,
      };
}
