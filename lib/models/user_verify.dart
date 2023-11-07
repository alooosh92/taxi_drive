class UserVerify {
  late int id;
  late String name;
  late String phone;
  late String role;
  late String? email;
  late String token;

  UserVerify({
    this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.token,
  });

  factory UserVerify.fromJson(Map<String, dynamic> json) {
    return UserVerify(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        role: json["role"],
        token: json["token"],
        email: json["email"] ?? "");
  }
}
