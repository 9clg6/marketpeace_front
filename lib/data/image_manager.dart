import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:market_peace/data/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageManager {
  static Future<String?> sendImageToFirebaseStorage(File file) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.get('userId');

      final ref = InstanceManager.firebaseStorageInstance.ref().child('${DateTime.now()}_$userId.jpg');
      await ref.putFile(file);

      return await ref.getDownloadURL();
    } on FirebaseException catch(_){
      return null;
    }
  }
}
