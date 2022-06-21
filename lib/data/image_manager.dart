import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:market_peace/data/instance_manager.dart';

class ImageManager {
  static Future<String?> sendImageToFirebaseStorage(File file) async {
    try {
      FlutterSecureStorage secureStorage = Get.find();
      final userId = await secureStorage.read(key: 'userId');

      final ref = InstanceManager.firebaseStorageInstance.ref().child('${DateTime.now()}_$userId.jpg');
      await ref.putFile(file);

      return await ref.getDownloadURL();
    } on FirebaseException catch(_){
      return null;
    }
  }
}
