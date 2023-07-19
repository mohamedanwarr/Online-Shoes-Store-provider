import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:online_shoes_shop/viwes/shared/CustomeSpacer.dart';

import '../../model/Sneakers_Model.dart';
import '../../services/Helper.dart';
import '../shared/Category_btn.dart';
import '../shared/LatestShoes.dart';
import '../shared/appstyle.dart';

class ProductByCart extends StatefulWidget {
   const ProductByCart({Key? key, required this.tabIndex}) : super(key: key);

   final int tabIndex;
  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this,
      initialIndex: widget.tabIndex);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _women;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getmaleSneakers();
  }

  void getwomen() {
    _women = Helper().getwomenSneakers();
  }

  void getkids() {
    _kids = Helper().getkidSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getwomen();
    getkids();
  }


  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: SizedBox(
                  height:MediaQuery.of(context).size.height *1 ,
                  child: Column(
                    children: [

                      Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black38),
                      ),
                      Column(
                        children: [
                          const CustomeSpacer(),
                          Text(
                            'Filter',
                            style: appstyle(48, Colors.black, FontWeight.bold),
                          ),
                          const CustomeSpacer(),
                          Text(
                            'Gender',
                            style: appstyle(20, Colors.black, FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              CategoryBtn(
                                buttoncolor: Colors.black,
                                lable: 'Men',
                              ),
                              CategoryBtn(
                                buttoncolor: Colors.grey,
                                lable: 'Women',
                              ),
                              CategoryBtn(
                                buttoncolor: Colors.grey,
                                lable: 'Kids',
                              ),
                            ],
                          ),
                          const CustomeSpacer(),
                          Text(
                            "Category",
                            style: appstyle(20, Colors.black, FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              CategoryBtn(
                                  buttoncolor: Colors.black, lable: 'Shoes'),
                              CategoryBtn(
                                  buttoncolor: Colors.grey, lable: 'Apparrels'),
                              CategoryBtn(
                                  buttoncolor: Colors.grey,
                                  lable: 'Accessories'),
                            ],
                          ),
                          const CustomeSpacer(),
                          Text(
                            'price',
                            style: appstyle(20, Colors.black, FontWeight.bold),
                          ),
                          const CustomeSpacer(),
                          Slider(
                              value: _value,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                              thumbColor: Colors.black,
                              max: 500,
                              divisions: 50,
                              label: _value.toString(),
                              secondaryTrackValue: 200,
                              onChanged: (double value) {
                                value = _value;
                              }),
                          const CustomeSpacer(),
                          Text(
                            'Btand',
                            style: appstyle(20, Colors.black, FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: 80,
                            child: ListView.builder(
                                itemCount: Brand.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(padding:const EdgeInsets.all(8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: const BorderRadius.all(Radius.circular(12)
                                        ),
                                      ),
                                      child: Image.asset(Brand[index],
                                        height: 60,
                                        width: 80,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
  List <String> Brand=[
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/top_image.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 5, 16, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Text('Men Shoes'),
                        Text('Women Shoes'),
                        Text('Kids Shoes'),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.180,
                  left: 16,
                  right: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(male: _male,),
                  LatestShoes(male: _women),
                  LatestShoes(male: _kids),
                  // WomenLatest(women: _women),
                  // KidsLatest(kids: _kids)
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
