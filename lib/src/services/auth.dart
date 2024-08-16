import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpResponse {
  final bool success;
  final String? error;
  final String? username;
  final List<String>? secrets;
  final String? profile;

  SignUpResponse(
    this.success, {
    this.error,
    this.username,
    this.secrets,
    this.profile,
  });
}

class AuthServices {
  // final FirebaseApp _app = Firebase.app();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserAuthSecrets() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("User not authenticated");
    }

    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection("users").doc(user.uid).get();

    return userDoc.data()!["_secrets"].cast<String>();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  String getRandomProfileSource() {
    final random = Random().nextInt(12).toString().padLeft(2, '0');
    return "https://cdn.mxpnl.com/static/tracked-user-icons/$random/192.png";
  }

  Future<List<String>> generateUserSecrets() async {
    final response = await http
        .get(Uri.parse("https://random-word-api.herokuapp.com/word?number=16"));
    if (response.statusCode == 200) {
      final List<String> words = jsonDecode(response.body).cast<String>();
      return words;
    } else {
      throw Exception("Failed to generate user secrets");
    }
  }

  void validateUsername({
    required String username,
  }) {
    if (username.isEmpty) {
      throw Exception("Username cannot be empty");
    }

    if (!RegExp(r"^[a-zA-Z0-9_.-]*$").hasMatch(username)) {
      throw Exception(
          "Username can only contain letters, numbers, hyphens, underscores, and dots");
    }

    if (!RegExp(r"^[a-zA-Z]").hasMatch(username)) {
      throw Exception("Username should start with a letter");
    }

    if (RegExp(r"[-_.]$").hasMatch(username)) {
      throw Exception(
          "Username should not end with a hyphen, underscore, or dot");
    }
  }

  void validatePassword({
    required String password,
    String? confirmPassword,
  }) {
    if (password.isEmpty) {
      throw Exception("Password cannot be empty");
    }

    if (password.length < 8) {
      throw Exception("Password should be at least 8 characters long");
    }

    if (confirmPassword != null) {
      if (confirmPassword.isEmpty) {
        throw Exception("Confirm password cannot be empty");
      }

      if (password != confirmPassword) {
        throw Exception("Passwords do not match");
      }
    }
  }

  Future<SignUpResponse> signUpUser({
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      validateUsername(username: username);
      validatePassword(password: password, confirmPassword: confirmPassword);

      final String email = "$username@carryon.vilfik.com";

      List<String> secrets = await generateUserSecrets();

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "username": username,
        "email": email,
        "_secrets": secrets,
      });

      // add username to user.displayName
      await userCredential.user!.updateDisplayName(username);

      String profile = getRandomProfileSource();

      await userCredential.user!.updatePhotoURL(profile);

      return SignUpResponse(
        true,
        username: username,
        secrets: secrets,
        profile: profile,
      );
    } catch (e) {
      return SignUpResponse(
        false,
        error: e.toString(),
      );
    }
  }

  Future<String> signInUser({
    required String username,
    required String password,
  }) async {
    try {
      validateUsername(username: username);
      validatePassword(password: password);

      final String email = "$username@carryon.vilfik.com";

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "true";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
    // sleep for 2 seconds to allow the sign out process to complete
    await Future.delayed(const Duration(microseconds: 256));
  }
}
