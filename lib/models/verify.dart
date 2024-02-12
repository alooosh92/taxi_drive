class Verify {
  late String phone;
  late String code;
  late String? fcmToken;

  Verify({required this.code, required this.phone, required this.fcmToken});

  Map<String, dynamic> toJson() =>
      {"phone": phone, "code": code, "fcm_token": fcmToken};
}
