
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_shoes_shop/Provider/ProductProvider.dart';
import 'package:online_shoes_shop/viwes/ui/MainScreen.dart';
import 'package:provider/provider.dart';

import 'Provider/MainScreenProvider.dart';
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenProvider()),
    ChangeNotifierProvider(create: (context)=>ProductNotifier())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
