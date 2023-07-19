import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../shared/appstyle.dart';

class FavPage extends StatefulWidget {
  FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  final _favbox = Hive.box('fav_box');

  _deleteFav(int key) async {
    await _favbox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> fav = [];

    final FavData = _favbox.keys.map((key) {
      final item = _favbox.get(key);
      return {
        'key': key,
        'id': item['id'],
        'name': item['name'],
        'category': item['category'],
        'price': item['price'],
        'imageUrl': item['imageUrl'],
        'sizes':item['sizes']
      };
    }).toList();

    fav = FavData.reversed.toList();

    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/top_image.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('My Favorites',
                      style: appstyle(36, Colors.white, FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                    itemCount: fav.length,
                    padding: const EdgeInsets.only(top: 100),
                    itemBuilder: (context, index) {
                      final shoe = fav[index];
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 11,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: const Offset(0, 1))
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Image.network(
                                            shoe ['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                            left: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                shoe['name'],
                                                style: appstyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                shoe['category'],
                                                style: appstyle(14, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              Row(children: [

                                                Text(
                                                  shoe['price'].toString(),
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "Size",
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  shoe['sizes'].toString(),
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ));
                    }),
              )
            ])));
  }
}
