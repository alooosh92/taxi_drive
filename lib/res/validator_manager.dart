class ValidatorManager {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "لا يمكن ترك هذا الحقل فارغاً";
    }
    if (!value.contains("@") || value.split("@").last.contains(".")) {
      return "الرجاء ادخال بريد الكتروني صحيح";
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "لا يمكن ترك هذا الحقل فارغاً";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "لا يمكن ترك هذا الحقل فارغاً";
    }
    if (value.length < 12) {
      return "الرجاء ادخال الرقم مع مفتاح الدولة";
    }
    return null;
  }
}
