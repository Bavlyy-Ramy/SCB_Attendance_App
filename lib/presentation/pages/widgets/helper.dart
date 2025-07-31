import 'package:firebase_auth/firebase_auth.dart';

String getFriendlyErrorMessage(FirebaseAuthException e) {
  switch (e.code) {
    case "email-already-in-use":
      return "This email is already registered.";
    case "invalid-email":
      return "Please enter a valid email address.";
    case "weak-password":
      return "Password must be at least 6 characters.";
    case "user-not-found":
      return "No account found with this email.";
    case "wrong-password":
      return "Incorrect password. Try again.";
    default:
      return "Something went wrong. Please try again.";
  }
}
