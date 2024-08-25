class ZFirebaseAuthException implements Exception {
  /// The error code associated with exception.
  final String code;

  /// Constructor that takes error code
  ZFirebaseAuthException(this.code);

  /// Get corresponding error message based on the error code
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address is not valid. Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please enter a stronger password.';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email. Please check the email address and try again.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification id. Please request a new verification id.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please login again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different signed in credentials.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign in again';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
