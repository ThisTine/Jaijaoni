import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

Future<void> uploadBill(File file, String namepic) async {
  try {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final mountainsRef = storageRef.child("bill/$namepic");

    if (kIsWeb) {
      await mountainsRef.putString(file.path);
      // await mountainsRef.putFile(file);
      // await mountainsRef.putData(
      //   file.readAsBytes() as Uint8List,
      //   SettableMetadata(contentType: 'image/jpeg'),
      // );
    } else {
      await mountainsRef.putFile(
          file,
          SettableMetadata(
            contentType: "image/*",
          ));
    }
  } catch (err) {
    rethrow;
  }
}
