class UpdateUser {
  late String name;
  late String phone;
  late String? email;
  late String region;

  UpdateUser({
    this.email,
    required this.name,
    required this.phone,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
        "city_address": region,
      };
}
