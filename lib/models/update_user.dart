class UpdateUser {
  late String name;
  late String phone;
  late String? email;

  UpdateUser({
    this.email,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
      };
}
