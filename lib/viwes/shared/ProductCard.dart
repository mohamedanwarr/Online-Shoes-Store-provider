import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:online_shoes_shop/model/Comstant.dart';
import 'package:online_shoes_shop/viwes/ui/fav_page.dart';

import 'appstyle.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key, required this.price, required this.category, required this.id, required this.name, required this.image})
      : super(key: key);

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _favbox = Hive.box('fav_box');

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _favbox.add(addFav);
    getFavorites();
  }

  getFavorites() {
    final favData = _favbox.keys.map((key) {
      final item = _favbox.get(key);

      return {
        'key': key,
        'id': item['id'],
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item) => item['id']).toList();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    bool selected = true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1)),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3,
                    decoration: BoxDecoration(
                        image:
                        DecorationImage(image: NetworkImage(widget.image))),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: () async {
                          if (ids.contains(widget.id)) {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>FavPage()));
                          }else{
                            _createFav({
                              'id': widget.id,
                              'name':widget.name,
                              'category': widget.category,
                              'imageUrl': widget.image

                            });
                          }
                        },
                        child: ids.contains(widget.id)? const Icon(AntDesign.heart):const Icon(AntDesign.hearto),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style:
                      appstylewithheight(
                          18, Colors.black, FontWeight.bold, 0.2),
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      widget.category,
                      style: appstylewithheight(
                          18, Colors.grey, FontWeight.bold, 1.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appstyle(26, Colors.black, FontWeight.w600),
                    ),
                    Text(
                      'Colors',
                      style: appstyle(18, Colors.grey, FontWeight.w500),
                    ),

                    ChoiceChip(
                      shape: const CircleBorder(),
                      label: const Text(''),
                      selected: selected,
                      visualDensity: VisualDensity.compact,
                      selectedColor: Colors.black,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

