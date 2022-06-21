import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:market_peace/model/response/sign_in_response.dart';

class SecuredStoreManager {
  static void clearSecuredStore(){
    FlutterSecureStorage secureStorage = Get.find();
    secureStorage.deleteAll();
  }

  static void storeInformations(SignInResponse signInResponse) {
    FlutterSecureStorage secureStorage = Get.find();

    secureStorage.write(
      key: 'bearerToken',
      value: signInResponse.token!,
    );
    secureStorage.write(
      key: 'userId',
      value: signInResponse.id.toString(),
    );
    secureStorage.write(
      key: 'username',
      value: signInResponse.username!,
    );
    secureStorage.write(
      key: 'email',
      value: signInResponse.email!,
    );
  }

}
