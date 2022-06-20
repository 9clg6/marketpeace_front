// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../guard/auth_guard.dart' as _i8;
import '../screens/home_page.dart' as _i1;
import '../screens/login_page.dart' as _i2;
import '../screens/new_ad_page.dart' as _i5;
import '../screens/profile_page.dart' as _i4;
import '../screens/register_page.dart' as _i3;

class AppRouter extends _i6.RootStackRouter {
  AppRouter(
      {_i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i8.AuthGuard authGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomePage.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    LoginPage.name: (routeData) {
      final args =
          routeData.argsAs<LoginPageArgs>(orElse: () => const LoginPageArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginPage(key: args.key));
    },
    RegisterPage.name: (routeData) {
      final args = routeData.argsAs<RegisterPageArgs>(
          orElse: () => const RegisterPageArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.RegisterPage(key: args.key));
    },
    ProfilePage.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ProfilePage());
    },
    NewAdPage.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.NewAdPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(HomePage.name, path: '/'),
        _i6.RouteConfig(LoginPage.name, path: '/login-page'),
        _i6.RouteConfig(RegisterPage.name, path: '/register-page'),
        _i6.RouteConfig(ProfilePage.name,
            path: '/profile-page', guards: [authGuard]),
        _i6.RouteConfig(NewAdPage.name,
            path: '/new-ad-page', guards: [authGuard])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePage extends _i6.PageRouteInfo<void> {
  const HomePage() : super(HomePage.name, path: '/');

  static const String name = 'HomePage';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPage extends _i6.PageRouteInfo<LoginPageArgs> {
  LoginPage({_i7.Key? key})
      : super(LoginPage.name,
            path: '/login-page', args: LoginPageArgs(key: key));

  static const String name = 'LoginPage';
}

class LoginPageArgs {
  const LoginPageArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'LoginPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterPage extends _i6.PageRouteInfo<RegisterPageArgs> {
  RegisterPage({_i7.Key? key})
      : super(RegisterPage.name,
            path: '/register-page', args: RegisterPageArgs(key: key));

  static const String name = 'RegisterPage';
}

class RegisterPageArgs {
  const RegisterPageArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'RegisterPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.ProfilePage]
class ProfilePage extends _i6.PageRouteInfo<void> {
  const ProfilePage() : super(ProfilePage.name, path: '/profile-page');

  static const String name = 'ProfilePage';
}

/// generated route for
/// [_i5.NewAdPage]
class NewAdPage extends _i6.PageRouteInfo<void> {
  const NewAdPage() : super(NewAdPage.name, path: '/new-ad-page');

  static const String name = 'NewAdPage';
}
