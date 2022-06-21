import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/guard/auth_guard.dart';
import 'package:market_peace/routing/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDgzusXW7WN5QH9KwbBdB34O6JPzZZI59s",
        authDomain: "marketpeace-ee123.firebaseapp.com",
        projectId: "marketpeace-ee123",
        storageBucket: "marketpeace-ee123.appspot.com",
        messagingSenderId: "298007993542",
        appId: "1:298007993542:web:30770d7694597295e68bc7"
    ),
  ).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter(authGuard: AuthGuard());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      popGesture: false,
      onInit: (){
        Get.put(const FlutterSecureStorage());
      },
      theme: buildThemeData(),
    );
  }

  buildThemeData() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: darkAccentuation,
    );
  }
}