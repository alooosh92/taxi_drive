class UserRegister {
  late String name;
  late String phone;
  late String? email;
  late String role = "user";

  UserRegister({required this.name, required this.phone, this.email});

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "role": role,
      };
}
