class Verify {
  late String phone;
  late String code;

  Verify({required this.code, required this.phone});
  Map<String, dynamic> toJson() => {
        "phone": phone,
        "code": code,
      };
}
