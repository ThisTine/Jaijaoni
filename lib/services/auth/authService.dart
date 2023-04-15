import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/material.dart';

class User {
  final String uid;
  final String? displayName;
  final String? photoURL;
  const User({required this.uid, this.displayName, this.photoURL});
}

class AuthService extends ChangeNotifier {
  final fauth.FirebaseAuth _firebaseAuth = fauth.FirebaseAuth.instance;

  User? _userFromFirebase(fauth.User? user) {
    notifyListeners();
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, displayName: user.displayName);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}
