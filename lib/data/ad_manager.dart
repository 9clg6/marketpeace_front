import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:market_peace/constants.dart';
import 'package:market_peace/data/secured_store_manager.dart';
import 'package:market_peace/exception/advertisement_exception.dart';

class AdManager {
  static Future<bool> saveAd({
    required String title,
    required double price,
    required String description,
    required String imageUrl,
  }) async {
    FlutterSecureStorage secureStorage = Get.find();
    final userId = await secureStorage.read(key: 'userId');
    final token = await secureStorage.read(key: 'bearerToken');

    final response = await http.post(
      Uri.parse("$apiAddress/api/advertisements/"),
      body: jsonEncode(
          {
            "title": title,
            "price": price,
            "description": description,
            "imageUrl": imageUrl,
            "ownerId": userId
          },
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if(response.statusCode == 401){
      throw AdvertisementException("Impossible de créer l'annonce");
    } else if(response.statusCode == 200){
       return true;
    } else {
      return false;
    }
  }
}
