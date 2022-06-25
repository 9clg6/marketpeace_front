import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/model/advertisement.dart';

class AdCard extends StatefulWidget {
  final Advertisement ad;
  const AdCard({Key? key, required this.ad}) : super(key: key);

  @override
  State<AdCard> createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  bool _loaded = false;
  late Image placeholder;
  late Image img;

  @override
  void initState() {
    super.initState();
    placeholder = Image.asset(
      'assets/default-placeholder.png',
    );

    if( widget.ad.imageUrl != null){
      img = Image.network(widget.ad.imageUrl!);
      img.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((image, synchronousCall) {
          if(mounted){
            setState(() => _loaded = true);
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 15,
      ),
      width: 270,
      height: 250,
      decoration: BoxDecoration(
        color: beige,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: _loaded ? img : placeholder,
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 200,
              width: 150,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.ad.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Prix: ${widget.ad.price!} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      widget.ad.description!,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
