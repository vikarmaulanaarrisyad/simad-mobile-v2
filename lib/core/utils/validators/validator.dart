class TValidator {
  // Empty text validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-2]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  static validatePassoword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password required';
    }

    // cek minimal password
    if (value.length < 6) {
      return 'Password must be at latest 6 characters long.';
    }

    // cek uppercase
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at latest one uppercase letter.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // reguler expression phone number validation
    final phoneRegExp = RegExp(r'^\d{10$}');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required)';
    }
    return null;
  }
}
