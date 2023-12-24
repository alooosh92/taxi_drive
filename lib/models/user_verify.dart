class UserVerify {
  late bool isAuthanticated;
  late String? name;
  //late String message;
  late String? email;
  late String? roles;
  late String? token;
  // late String? refreshToken;
  late String? phone;
  // late DateTime? refreshTokenExpireson;

  UserVerify({
    required this.email,
    required this.isAuthanticated,
    required this.name,
    required this.phone,
    required this.roles,
    required this.token,
  });

  factory UserVerify.fromJson(Map<String, dynamic> json) {
    return UserVerify(
      email: json["email"],
      isAuthanticated: json["isAuthanticated"],
      phone: json["phone"],
      name: json["name"],
      roles: json["roles"],
      token: json["token"],
    );
  }
}
