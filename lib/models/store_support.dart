class StoreSupport {
  late String name;
  late String phone;
  late String subject;
  late String message;

  StoreSupport({
    required this.message,
    required this.name,
    required this.phone,
    required this.subject,
  });

  Map<String, dynamic> toJson() => {
        "message": message,
        "name": name,
        "phone": phone,
        "subject": subject,
      };
}
