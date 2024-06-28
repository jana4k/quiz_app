import 'package:firebase_auth/firebase_auth.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  weakPassword,
  undefined,
}

class AuthExceptionHandler {
  static handleException(FirebaseAuthException e) {
    AuthResultStatus result;
    switch (e.code) {
      case 'invalid-email':
        result = AuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        result = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        result = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        result = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        result = AuthResultStatus.operationNotAllowed;
        break;
      case 'operation-not-allowed':
        result = AuthResultStatus.operationNotAllowed;
        break;
      case 'email-already-in-use':
        result = AuthResultStatus.emailAlreadyExists;
        break;
      case 'weak-password':
        result = AuthResultStatus.weakPassword;
        break;
      default:
        result = AuthResultStatus.undefined;
    }
    return result;
  }

  static String generateExceptionMessage(AuthResultStatus result) {
    String message;
    switch (result) {
      case AuthResultStatus.invalidEmail:
        message = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        message = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        message = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        message = "User with this email has been disabled.";
        break;
      case AuthResultStatus.operationNotAllowed:
        message = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        message = "The email has already been registered. Please login.";
        break;
      case AuthResultStatus.weakPassword:
        message = "The password provided is too weak.";
        break;
      default:
        message = "An undefined Error happened.";
    }
    return message;
  }
}
