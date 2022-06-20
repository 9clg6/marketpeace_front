import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:market_peace/exception/authentication_exception.dart';
import 'package:market_peace/exception/register_exception.dart';
import 'package:market_peace/model/response/sign_in_response.dart';

class AuthManager {
  static const _apiAddress = 'http://192.168.0.34:8080';

  static Future<bool> signIn({required String username, required String password}) async {
    bool authResult = false;

    if (username.isNotEmpty && password.isNotEmpty) {
      final response = await http.post(
        Uri.parse("$_apiAddress/api/auth/signin"),
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 401) {
        throw AuthenticationException("${response.statusCode}");
      } else if (response.statusCode == 200) {
        final signInResponse = SignInResponse.fromJson(jsonDecode(response.body));

        FlutterSecureStorage secureStorage = Get.find();
        secureStorage.write(
          key: 'bearerToken',
          value: signInResponse.token!,
        );
        authResult = response.statusCode == 200;
      }
    }

    return authResult;
  }

  static Future<bool> signup({
    required String username,
    required String password,
    required String mailAddress,
    String? name,
    String? surname,
  }) async {
    bool registerResult = false;

    if (username.isNotEmpty && password.isNotEmpty && mailAddress.isNotEmpty) {
      final response = await http.post(
        Uri.parse("$_apiAddress/api/auth/signup"),
        body: jsonEncode(
          {
            'mail_address': mailAddress,
            'name': name ?? "",
            'surname': surname ?? "",
            'password': password,
            'username': username,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );


      if (response.statusCode == 400) {
        throw RegisterException("Pseudo ou adresse mail déjà utilisée");
      } else if (response.statusCode != 200) {
        throw RegisterException("${response.statusCode}");
      } else if (response.statusCode == 200) {
        await signIn(username: username, password: password);

        registerResult = true;
      }
    }

    return registerResult;
  }
}
