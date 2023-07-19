import 'package:flutter/services.dart' as the_bundle;

import '../model/Sneakers_Model.dart';

class Helper {
  //men
  Future<List<Sneakers>> getmaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/men_shoes.json');
    final malelist=sneakersFromJson(data);
    return malelist;
  }
  //women
  Future<List<Sneakers>> getwomenSneakers() async {
    final data =
    await the_bundle.rootBundle.loadString('assets/json/women_shoes.json');
    final womenlist=sneakersFromJson(data );
    return womenlist;
  }
  //kids
  Future<List<Sneakers>> getkidSneakers() async {
    final data =
    await the_bundle.rootBundle.loadString('assets/json/kids_shoes.json');
    final kidslist=sneakersFromJson(data );
    return kidslist;
  }
//single male
  Future<Sneakers> getmaleSneakersById(String id) async {
    final data =
    await the_bundle.rootBundle.loadString('assets/json/men_shoes.json');
    final malelist = sneakersFromJson(data);
    final sneaker = malelist.firstWhere(
          (sneaker) => sneaker.id == id,
      orElse: () => Sneakers(),
    );
    return sneaker;
  }
  //single women
  Future<Sneakers> getwomenSneakersById(String id) async {
    final data =
    await the_bundle.rootBundle.loadString('assets/json/women_shoes.json');
    final womenlist = sneakersFromJson(data);
    final sneaker = womenlist.firstWhere(
          (sneaker) => sneaker.id == id,
      orElse: () => Sneakers(),
    );
    return sneaker;
  }
  //single kids
  Future<Sneakers> getkidSneakersById(String id) async {
    final data =
    await the_bundle.rootBundle.loadString('assets/json/kids_shoes.json');
    final kidslist = sneakersFromJson(data);
    final sneaker = kidslist.firstWhere(
          (sneaker) => sneaker.id == id,
      orElse: () => Sneakers(),
    );
    return sneaker;
  }
}
