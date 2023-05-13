import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> saveTokenToDatabase(String token) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  await FireStoreService.collection.users.doc(userId).update({'tokens': FieldValue.arrayUnion([token])});
}