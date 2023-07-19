import 'package:flutter/material.dart';
import 'package:online_shoes_shop/viwes/shared/appstyle.dart';

class Stagger_tile extends StatelessWidget {
  const Stagger_tile(
      {Key? key, required this.image,required  this.price,required  this.name})
      : super(key: key);
  final String image;
  final String price;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              image,
              fit: BoxFit.fill,
            ),

            Container(
              height: 70,
              padding: const EdgeInsets.only(top: 11),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: appstylewithheight(18, Colors.black, FontWeight.w700,0.9),
                  ),

                  Text(
                    price,
                    style: appstylewithheight(18, Colors.black, FontWeight.w500,0.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
