import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/widgets/custom_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildNavigationBar(),
      body: Stack(
        children: [
          buildBackground(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: buildBody(),
          ),
        ],
      ),
    );
  }

  Container buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        color: lightAccentuation,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(50),
          bottomEnd: Radius.circular(50),
        ),
      ),
      height: 400,
      width: double.infinity,
    );
  }

  CustomNavigationBar buildNavigationBar() {
    return CustomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      backgroundColor: lightAccentuation,
      selectedColor: distinctiveColor,
      unSelectedColor: white,
      strokeColor: white,
      items: [
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.home,
          ),
          title: const Text(
            "Accueil",
            style: TextStyle(
              color: white,
            ),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.dashboard,
          ),
          title: const Text(
            "Parcourir",
            style: TextStyle(
              color: white,
            ),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.search,
          ),
          title: const Text(
            "Rechercher",
            style: TextStyle(
              color: white,
            ),
          ),
        ),
      ],
    );
  }

  buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          buildAppTitle(),
          const CustomSearchBar(),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCreateAdBtn(),
              buildCarousel(),
              buildFavoriteColumn(),
            ],
          ),
        ),
      ),
    );
  }

  buildFavoriteColumn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "Annonces favorites ❤️",
                style: TextStyle(
                  color: distinctiveColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 800,
            child: ListView.builder(
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: beige,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 150,
                    width: 250,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        autoPlay: true,
        height: 250,
        enlargeCenterPage: true,
        disableCenter: true,
      ),
      items: [
        ...List.generate(30, (index) {
          return Container(
            width: 270,
            height: 250,
            decoration: BoxDecoration(
              color: beige,
              borderRadius: BorderRadius.circular(25),
            ),
          );
        })
      ],
    );
  }

  buildAppTitle() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        "MarketPeace",
        style: TextStyle(
          color: white,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          decorationThickness: 40,
          letterSpacing: 3,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(3, 3),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCreateAdBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(3, 3),
            )
          ],
          color: distinctiveColor,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "créer une",
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Nouvelle annonce",
                  style: TextStyle(
                    color: white,
                    fontSize: 25,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
