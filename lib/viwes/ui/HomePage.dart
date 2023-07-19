import 'package:flutter/material.dart';
import 'package:online_shoes_shop/viwes/shared/appstyle.dart';

import '../../model/Sneakers_Model.dart';
import '../../services/Helper.dart';
import '../shared/HomeWidegt.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
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
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Athletices Shoes',
                        style: appstylewithheight(
                            35, Colors.white, FontWeight.bold, 1.2),
                      ),
                      Text(
                        'Collection',
                        style: appstylewithheight(
                            35, Colors.white, FontWeight.bold, 1.2),
                      ),
                      const SizedBox(
                        height: 5,
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
                        ],

                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.265),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(
                      male: _male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      male: _women,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: _kids, tabIndex: 2,
                    ),
                    // WomenWidget(women: _women),
                    // KidWidget(Kid:_kids ),
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
