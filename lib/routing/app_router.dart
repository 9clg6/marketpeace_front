import 'package:auto_route/auto_route.dart';
import 'package:market_peace/guard/auth_guard.dart';
import 'package:market_peace/screens/home_page.dart';
import 'package:market_peace/screens/login_page.dart';
import 'package:market_peace/screens/new_ad_page.dart';
import 'package:market_peace/screens/profile_page.dart';
import 'package:market_peace/screens/register_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(name: "HomePage", page: HomePage, initial: true),
    AutoRoute(name: "LoginPage", page: LoginPage),
    AutoRoute(name: "RegisterPage", page: RegisterPage),
    AutoRoute(name: "ProfilePage", page: ProfilePage, guards: [AuthGuard]),
    AutoRoute(name: "NewAdPage", page: NewAdPage, guards: [AuthGuard]),
  ],
)
class $AppRouter {}
