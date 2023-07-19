import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic>? _shoeSizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;

  set activepage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List? get shoeSizes => _shoeSizes ?? [];

  set shoeSizes(List<dynamic>?newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheack(int index) {
    for (int i = 0; i < _shoeSizes!.length; i++) { // Added the increment statement "i++"
      if (i == index) {
        _shoeSizes![i]['isSelected'] = !_shoeSizes![i]['isSelected'];
      }
    }
    notifyListeners();
  }
List <String> get sizes=> _sizes;

  set sizes(List<String> newSizes){
    _sizes=newSizes;
    notifyListeners();
  }

}