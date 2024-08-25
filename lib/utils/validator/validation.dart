class ZValidation {
  /// Empty Text String
  static String? validateEmptyText(String? fieldName, String? value) {
    if (fieldName == null || value!.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required!';
    }

    // --- Regular Expression for email validation
    final emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegEx.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  ///   Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required!';
    }

    // Check for minimum password check
    if (value.length < 6) {
      return 'Password must contain at least 6 character long';
    }

    // Check for upper case
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one upper case';
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validatePhoneNumber(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required!';
    }

    // Regular Expression for phone number validation (assuming a 11 digit for PK phone number format )
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required)!';
    }

    return null;
  }

  /// Add More Custom Validation as per need
}
