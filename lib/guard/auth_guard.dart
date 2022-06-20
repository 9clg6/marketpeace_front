import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    FlutterSecureStorage secureStorage = Get.find();

    secureStorage.read(key: 'bearerToken').then((value){
      if(value == null){
        router.pushNamed('/login-page');
      } else {
        resolver.next();
      }
    });
  }
}