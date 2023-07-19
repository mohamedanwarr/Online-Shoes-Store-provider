import 'package:flutter/material.dart';
import 'package:online_shoes_shop/Provider/MainScreenProvider.dart';

import 'package:online_shoes_shop/viwes/ui/HomePage.dart';
import 'package:online_shoes_shop/viwes/ui/ProfilePage.dart';
import 'package:online_shoes_shop/viwes/ui/SearchPage.dart';
import 'package:provider/provider.dart';

import '../shared/BottomNav.dart';
import 'Cart_Page.dart';
import 'fav_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList =  [
    const HomePage(),
    const SearchPage(),
    FavPage(),
    Cart(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Consumer<MainScreenProvider>(
      builder: (BuildContext context, MainScreenProvider,  child) {
       return Scaffold(
         backgroundColor: const Color(0xFFE2E2E2),
         body: pageList[MainScreenProvider.pageIndex],
         bottomNavigationBar: const BottoNva(),
       );
      },

    );
  }
}

