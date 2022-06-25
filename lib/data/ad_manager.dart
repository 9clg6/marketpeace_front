import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:market_peace/constants.dart';
import 'package:market_peace/exception/advertisement_exception.dart';
import 'package:market_peace/model/advertisement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdManager {

  static Future<List<Advertisement>> getAds() async {
    const uri = "$apiAddress/api/advertisements/";

    final response = await http.get(Uri.parse(uri));
    final adList = (jsonDecode(response.body) as List).map((e) => Advertisement.fromJson(e)).toList();

    if(response.statusCode == 401){
      throw AdvertisementException("Accès interdit");
    } else if(response.statusCode == 200){
      return adList;
    } else {
      return [];
    }
  }

  static Future<bool> saveAd({
    required String title,
    required double price,
    required String description,
    required String imageUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final token = prefs.getString('bearerToken');

    final response = await http.put(
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
