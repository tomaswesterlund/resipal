class PhoneFormatter {
  static String toRaw(String? value) {
    if (value == null) return '';
    return value.replaceAll(RegExp(r'[^\d+]'), '');
  }

  static String toDisplay(String? phone) {
    if (phone == null || phone.isEmpty) return "";

    // 1. Extraer solo los dígitos (limpia +, -, (), espacios, etc.)
    String digits = phone.replaceAll(RegExp(r'\D'), '');

    // 2. Si el número trae el código de país de México (52) al inicio, lo removemos
    // para mantener el formato nacional de 10 dígitos solicitado.
    if (digits.startsWith('52') && digits.length > 10) {
      digits = digits.substring(2);
    }

    if (digits.isEmpty) return "";

    // 3. Aplicar el formato xx xxxx xxxx
    final buffer = StringBuffer();
    final int len = digits.length;

    for (int i = 0; i < len; i++) {
      buffer.write(digits[i]);

      // Insertar espacio después del 2do dígito y después del 6to dígito
      if (i == 1 && len > 2) {
        buffer.write(' ');
      } else if (i == 5 && len > 6) {
        buffer.write(' ');
      }
    }

    return buffer.toString().trim();
  }
}
