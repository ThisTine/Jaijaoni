import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String uid;
  final String? displayName;
  final String? photoURL;
  const User({required this.uid, this.displayName, this.photoURL});
}

class AuthService {
  final fauth.FirebaseAuth _firebaseAuth = fauth.FirebaseAuth.instance;

  User? _userFromFirebase(fauth.User? user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, displayName: user.displayName);
  }

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> googleLogin() async {}

  Future<void> microsoftLogin() async {}

  Future<void> appleLogin() async {}

  Future<UserCredential> signup(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}
