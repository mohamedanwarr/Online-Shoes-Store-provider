import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:online_shoes_shop/viwes/shared/appstyle.dart';

import '../shared/BottomNavigsteBarWidegt.dart';
import '../shared/CheckoutButton.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  final _carBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _carBox.keys.map((key) {
      final item = _carBox.get(key);
      return {
        'key': key,
        'id': item['id'],
        'name': item['name'],
        'category': item['category'],
        'imageUrl': item['imageUrl'],
        'sizes': item['sizes'],
        'price': item['price'],
        'qty': item['qty'],
      };
    }).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'My Cart',
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final data = cart[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            flex: 1,
                                            backgroundColor: const Color(0xFF000000),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                            onPressed:
                                                (BuildContext context) {},
                                          )
                                        ]),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
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
                                                  data['imageUrl'],
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
                                                      data['name'],
                                                      style: appstyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      data['category'],
                                                      style: appstyle(
                                                          14,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                    Row(children: [
                                                      Text(
                                                        data['price'],
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
                                                        data['sizes'].toString(),
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {

                                                        },
                                                        child: const Icon(
                                                          AntDesign.minussquare,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        data['qty'].toString(),
                                                        style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                          AntDesign.plussquare,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }),
                    ),
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: CheackoutButton(title: 'Proceed to Checkout', ontap: () {  },))
          ],
        ),
      ),
    );
  }
}
