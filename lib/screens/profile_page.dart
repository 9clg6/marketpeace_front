import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:market_peace/data/secured_store_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: context.router.pop,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Flexible(
            child: Text("Flemme de faire cette page, go faire les MVP"),
          ),
          InkWell(
            onTap: () {
              SecuredStoreManager.clearSecuredStore();
              context.router.pushNamed('/');
            },
            child: Center(
              child: Container(
                color: Colors.red,
                width: 150,
                height: 100,
                alignment: Alignment.center,
                child: const Text("Se déconnecter"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
