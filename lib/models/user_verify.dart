class UserVerify {
  late bool isAuthanticated;
  late String message;
  late String? email;
  late List<String>? roles;
  late String? token;
  late String? refreshToken;
  late String? phone;
  late DateTime? refreshTokenExpireson;

  UserVerify({
    required this.email,
    required this.isAuthanticated,
    required this.message,
    required this.phone,
    required this.refreshToken,
    required this.refreshTokenExpireson,
    required this.roles,
    required this.token,
  });

  factory UserVerify.fromJson(Map<String, dynamic> json) {
    List<String> roles = [];
    if (json["roles"] != null) {
      for (var element in json["roles"]) {
        roles.add(element);
      }
    }
    return UserVerify(
      email: json["email"],
      isAuthanticated: json["isAuthanticated"],
      message: json["message"],
      phone: json["phone"],
      refreshToken: json["refreshToken"],
      refreshTokenExpireson: json["refreshTokenExpireson"] == null
          ? null
          : DateTime.parse(json["refreshTokenExpireson"]),
      roles: roles,
      token: json["token"],
    );
  }
}
