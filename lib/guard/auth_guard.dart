import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.get('bearerToken');

    if(result == null){
      router.pushNamed('/login-page');
    } else {
      resolver.next();
    }
  }
}