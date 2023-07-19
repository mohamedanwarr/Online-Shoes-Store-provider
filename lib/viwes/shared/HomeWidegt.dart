import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:online_shoes_shop/Provider/ProductProvider.dart';
import 'package:online_shoes_shop/viwes/ui/ProductByCart.dart';
import 'package:online_shoes_shop/viwes/ui/ProductPage.dart';
import 'package:provider/provider.dart';

import '../../model/Sneakers_Model.dart';
import 'NewShoes.dart';
import 'ProductCard.dart';
import 'appstyle.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error${snapshot.hasError}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                         productNotifier.shoeSizes = shoe.sizes;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductPage(
                                id: "${shoe.id}",
                                category: "${shoe.category}",
                              );
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        price: "\$${shoe.price}",
                        category: '${shoe.category}',
                        id: '${shoe.id}',
                        name: '${shoe.name}',
                        image: shoe.imageUrl![0],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 28, 12, 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductByCart(
                        tabIndex: tabIndex,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest Shoes',
                      style: appstyle(19, Colors.black, FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(19, Colors.black, FontWeight.bold),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error${snapshot.hasError}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final shoe = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoes(
                        Image: shoe.imageUrl![1],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

