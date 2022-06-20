import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      floating: true,
      pinned: false,
      snap: true,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(3, 3),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.brown,
                    ),
                    Flexible(
                      child: Text(
                        "Appuyez ici pour rechercher une annonce",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => context.router.pushNamed('/profile-page'),
            child: const CircleAvatar(
              backgroundColor: distinctiveColor,
              child: Icon(
                Icons.person,
                color: beige,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
