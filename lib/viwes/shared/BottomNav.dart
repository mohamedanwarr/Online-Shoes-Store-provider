import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../Provider/MainScreenProvider.dart';
import 'BottomNavigsteBarWidegt.dart';

class BottoNva extends StatelessWidget {
  const BottoNva({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
        builder: (BuildContext context, MainScreenProvider, child){
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavigsteBar(
                    onTap: () {
                      MainScreenProvider.pageIndex = 0;
                    },
                    icon: MainScreenProvider.pageIndex == 0 ?
                    MaterialCommunityIcons.home :
                    MaterialCommunityIcons.home_outline
                ),
                BottomNavigsteBar(
                    onTap: () {
                      MainScreenProvider.pageIndex = 1;
                    },
                    icon: MainScreenProvider.pageIndex == 1 ?
                    Ionicons.ios_search :
                    Ionicons.ios_search
                ),
                BottomNavigsteBar(
                    onTap: () {
                      MainScreenProvider.pageIndex = 2;
                    },

                    icon: MainScreenProvider.pageIndex == 2 ?
                    Ionicons.md_heart
                        : MaterialCommunityIcons.heart_circle_outline
                ),
                BottomNavigsteBar(
                  onTap: () {
                    MainScreenProvider.pageIndex = 3;
                  },
                  icon: MainScreenProvider.pageIndex == 3 ?
                  Ionicons.ios_cart :
                  Ionicons.md_cart
                  ,
                ),
                BottomNavigsteBar(
                    onTap: () {
                      MainScreenProvider.pageIndex = 4;
                    },
                    icon: MainScreenProvider.pageIndex == 4 ?
                    Ionicons.ios_person :
                    Ionicons.ios_person_add
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }
}

