import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:online_shoes_shop/Provider/ProductProvider.dart';
import 'package:online_shoes_shop/viwes/shared/appstyle.dart';
import 'package:online_shoes_shop/viwes/ui/fav_page.dart';
import 'package:provider/provider.dart';

import '../../model/Comstant.dart';
import '../../model/Sneakers_Model.dart';
import '../../services/Helper.dart';
import '../shared/CheckoutButton.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.id, required this.category})
      : super(key: key);
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  late Future<Sneakers> _sneaker;
  final _CartBox = Hive.openBox('cart_box');
  final _favbox = Hive.box('fav_box');

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getmaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getwomenSneakersById(widget.id);
    } else {
      _sneaker = Helper().getkidSneakersById(widget.id);
    }
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

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
    setState(() {});
  }

  Future<void> _creatCart(Map<String, dynamic> newCart) async {
    final Box = await _CartBox;
    newCart['sizes'] = newCart['sizes'].join(", ");
    await Box.add(newCart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: _sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text("Connection state: None"),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                return const Center(
                  child: Text("Connection state: Active"),
                );
              } else {
                final sneaker = snapshot.data;
                return Consumer<ProductNotifier>(
                    builder: (context, ProductNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  ProductNotifier.shoeSizes!.clear();
                                },
                                child: const Icon(
                                  AntDesign.close,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  AntDesign.ellipsis1,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sneaker!.imageUrl!.length,
                                    controller: pageController,
                                    onPageChanged: (index) {
                                      ProductNotifier.activepage = index;
                                    },
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.39,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.grey.shade300,
                                            child: Image.network(
                                              sneaker.imageUrl![index].isEmpty
                                                  ? "not found"
                                                  : sneaker.imageUrl![index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              right: 15,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    if (ids
                                                        .contains(widget.id)) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      FavPage()));
                                                    } else {
                                                      _createFav({
                                                        'id': sneaker.id,
                                                        'name':sneaker.name,
                                                        'category': sneaker.category,
                                                        'imageUrl': sneaker.imageUrl![1],
                                                      });
                                                    }
                                                  },
                                                  child:
                                                      ids.contains(sneaker.id)
                                                          ? const Icon(
                                                              AntDesign.heart,
                                                            )
                                                          : const Icon(
                                                              AntDesign.hearto,
                                                            ))),
                                          Positioned(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ...List<Widget>.generate(
                                                      sneaker.imageUrl!.length,
                                                      (index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            ProductNotifier
                                                                        .activepage !=
                                                                    index
                                                                ? Colors.grey
                                                                : Colors.black,
                                                      ),
                                                    );
                                                  })
                                                ],
                                              )),
                                        ],
                                      );
                                    }),
                              ),
                              Positioned(
                                  bottom: 65,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.610,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${sneaker.name}",
                                                style: appstyle(
                                                    28,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${sneaker.category}",
                                                    style: appstyle(
                                                        17,
                                                        Colors.grey,
                                                        FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 4,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 22,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1),
                                                    onRatingUpdate: (rating) {},
                                                    itemBuilder:
                                                        (context, index) {
                                                      return const Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color: Colors.black,
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '\$${sneaker.price}',
                                                    style: appstyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Colors",
                                                        style: appstyle(
                                                            15,
                                                            Colors.black,
                                                            FontWeight.w500),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            Colors.black,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Select size',
                                                        style: appstyle(
                                                            17,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "View size guide",
                                                        style: appstyle(
                                                            17,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            ProductNotifier
                                                                    .shoeSizes
                                                                    ?.length ??
                                                                0,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final sizes =
                                                              ProductNotifier
                                                                      .shoeSizes![
                                                                  index];
                                                          return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: ChoiceChip(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              60)),
                                                                      side: BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              1,
                                                                          style: BorderStyle
                                                                              .solid)),
                                                                  disabledColor:
                                                                      Colors
                                                                          .white,
                                                                  label: Text(
                                                                    "${sizes['size']}",
                                                                    style: appstyle(
                                                                        18,
                                                                        sizes['isSelected']
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        FontWeight
                                                                            .w600),
                                                                  ),
                                                                  selectedColor:
                                                                      Colors
                                                                          .black,
                                                                  selected: sizes[
                                                                      'isSelected'],
                                                                  onSelected:
                                                                      (newState) {
                                                                    if (ProductNotifier
                                                                        .sizes
                                                                        .contains(
                                                                            sizes['size'])) {
                                                                      ProductNotifier
                                                                          .sizes
                                                                          .remove(
                                                                              sizes['size']);
                                                                    } else {
                                                                      ProductNotifier
                                                                          .sizes
                                                                          .add(sizes[
                                                                              'size']);
                                                                    }
                                                                    ProductNotifier
                                                                        .toggleCheack(
                                                                            index);
                                                                  }));
                                                        }),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                indent: 10,
                                                endIndent: 10,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: Text(
                                                  "${sneaker.title}",
                                                  style: appstyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w700),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${sneaker.description}',
                                                style: appstyle(
                                                    14,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: CheackoutButton(
                                                    title: 'Add to Cart',
                                                    ontap: () async {
                                                      _creatCart({
                                                        'id': sneaker.id,
                                                        'name': sneaker.name,
                                                        'sizes': ProductNotifier
                                                            .sizes,
                                                        'category':
                                                            sneaker.category,
                                                        'imageUrl': sneaker
                                                            .imageUrl![0],
                                                        'price': sneaker.price,
                                                        'qty': 1,
                                                      });
                                                      ProductNotifier.sizes
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
              }
            }));
  }
}
