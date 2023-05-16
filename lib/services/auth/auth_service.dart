import 'package:cloud_firestore/cloud_firestore.dart' as fstore;
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jaijaoni/firebase_options.dart';
import 'package:jaijaoni/model/user.model.dart' as umodal;
import 'package:jaijaoni/services/store/fire_store_service.dart';

class User {
  final String uid;
  final String? displayName;
  final String? photoURL;
  const User({required this.uid, this.displayName, this.photoURL});
}

class AuthService {
  final fauth.FirebaseAuth _firebaseAuth = fauth.FirebaseAuth.instance;
  final fstore.FirebaseFirestore _fireStore = fstore.FirebaseFirestore.instance;

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
      // umodal.Users user = umodal.Users(
      //     userId: signedInCredential.user!.uid,
      //     profilePic: signedInCredential.user!.photoURL ?? "",
      //     username: signedInCredential.user!.email ?? "",
      //     name: signedInCredential.user!.email ?? "",
      //     charts: [],
      //     friendList: [],
      //     accs: []);
      // await _addUserToDB(user);
    } on fauth.FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on fauth.FirebaseAuthException {
      rethrow;
    }
  }

  Future<bool> _findValidUsername(String username) async {
    try {
      final querySnapShot = await _fireStore
          .collection("Users")
          .where("username", isEqualTo: username)
          .get();
      if (querySnapShot.docs.isEmpty) return true;
      throw "Username $username is already exists";
    } catch (err) {
      rethrow;
    }
  }

  Future<void> _addUserToDB(umodal.Users user) async {
    try {
      // print("Users");
      var usr = await FireStoreService.collection.users.doc(user.userId).get();
      // print(usr);
      var payloadMap = {
        "username": user.username,
        "name": user.name,
        "profilePic": user.profilePic,
        "accs": [],
        "friendList": [],
        "charts": []
      };
      if (!usr.exists) {
        await _fireStore.collection("Users").doc(user.userId).set(payloadMap);
        // await _fireStore
        //     .collection("Users")
        //     .doc(user.userId)
        //     .update(payloadMap);
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ], clientId: DefaultFirebaseOptions.currentPlatform.iosClientId)
          .signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = fauth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final signedInCredential =
          await _firebaseAuth.signInWithCredential(credential);
      String username = (signedInCredential.user!.email ?? "")
          .toLowerCase()
          .replaceAll(' ', '');
      umodal.Users user = umodal.Users(
          userId: signedInCredential.user!.uid,
          profilePic: signedInCredential.user!.photoURL ?? "",
          username: username,
          name: signedInCredential.user!.email ?? "",
          charts: [],
          friendList: [],
          accs: []);
      await _addUserToDB(user);

      if (signedInCredential.user!.displayName == null) {
        await signedInCredential.user!
            .updateDisplayName(signedInCredential.user!.email);
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> googleLoginWeb() async {
    try {
      fauth.GoogleAuthProvider googleProvider = fauth.GoogleAuthProvider();

      googleProvider.addScope('https://www.googleapis.com/auth/userinfo.email');
      googleProvider
          .addScope('https://www.googleapis.com/auth/userinfo.profile');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      final signedInCredential =
          await _firebaseAuth.signInWithPopup(googleProvider);
      if (signedInCredential.user!.displayName == null) {
        await signedInCredential.user!
            .updateDisplayName(signedInCredential.user!.email);
      }
      String username = (signedInCredential.user!.email ?? "")
          .toLowerCase()
          .replaceAll(' ', '');
      umodal.Users user = umodal.Users(
          userId: signedInCredential.user!.uid,
          profilePic: signedInCredential.user!.photoURL ?? "",
          username: username,
          name: signedInCredential.user!.email ?? "",
          charts: [],
          friendList: [],
          accs: []);
      await _addUserToDB(user);
    } on fauth.FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> microsoftLogin() async {}

  Future<void> appleLogin() async {}

  Future<void> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (err) {
      rethrow;
    }
  }

  Future<fauth.UserCredential> signup(
      String rawusername, String email, String password) async {
    String username = rawusername.toLowerCase().replaceAll(' ', '');
    try {
      await _findValidUsername(username);
      final signedUpCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await signedUpCredential.user!.updateDisplayName(username);
      umodal.Users user = umodal.Users(
          userId: signedUpCredential.user!.uid,
          profilePic: signedUpCredential.user!.photoURL ?? "",
          username: username,
          name: username,
          charts: [],
          friendList: [],
          accs: []);
      await _addUserToDB(user);
      return signedUpCredential;
    } catch (err) {
      rethrow;
    }
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}
