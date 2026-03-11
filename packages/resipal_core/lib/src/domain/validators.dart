class Validators {
  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;

    final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static bool isValidPhone(String? phone) {
    if (phone == null || phone.isEmpty) return false;
    final RegExp phoneRegExp = RegExp(r"^\+?[0-9]{7,15}$");
    return phoneRegExp.hasMatch(phone);
  }
}
