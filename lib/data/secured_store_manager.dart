import 'package:market_peace/model/response/sign_in_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecuredStoreManager {
  static void clearSecuredStore() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> storeInformations(SignInResponse signInResponse) async {
    final prefs = await SharedPreferences.getInstance();
    print(signInResponse.token);
    prefs.setString(
      'bearerToken',
      signInResponse.token!,
    );

    prefs.setString(
      'userId',
      signInResponse.id.toString(),
    );

    prefs.setString(
      'username',
      signInResponse.username!,
    );
    prefs.setString(
      'email',
      signInResponse.email!,
    );
  }

}
