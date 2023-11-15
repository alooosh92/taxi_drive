class UserRegister {
  late String name;
  late String phone;
  late String? email;

  UserRegister({required this.name, required this.phone, this.email});

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
      };
}
