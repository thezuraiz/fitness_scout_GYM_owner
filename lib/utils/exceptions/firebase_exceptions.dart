class ZFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  ZFirebaseException(this.code);

  /// Get corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'invalid-email':
        return 'The email address is not valid. Please enter a valid email address.';
      case 'user-not-found':
        return 'No user found with this email. Please check the email address and try again.';
      case 'email-already-in-use':
        return 'The email address already registered. Please use a different email';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'week-password':
        return 'The password is too week. Please choose a strong password.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider';
      case 'action-not-allowed':
        return 'This operation is not allowed. Contact support for assistance';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'captcha-check-failed':
        return 'The reCAPTCHA response is invalid. Please try again';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided api keys';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
