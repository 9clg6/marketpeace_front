import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/data/ad_manager.dart';
import 'package:market_peace/data/secured_store_manager.dart';
import 'package:market_peace/model/advertisement.dart';
import 'package:market_peace/widgets/ad_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        backgroundColor: distinctiveColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: context.router.pop,
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildMyAdsListView(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              SecuredStoreManager.clearSecuredStore();
              context.router.pushNamed('/');
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.red,
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "Se déconnecter",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMyAdsListView() {
    return FutureBuilder(
      future: AdManager.getAds(true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final adsList = snapshot.data as List<Advertisement>;

          return Column(
            children: [
              const Text("List de mes annonces"),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: adsList.length,
                  itemBuilder: (context, index) {
                    return Text("Titre: ${adsList.elementAt(index).title!}");
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
