import 'package:flutter/material.dart';
class NewShoes extends StatelessWidget {
   const NewShoes({
    super.key, required this.Image,
  });
  final String Image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  Image)
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(
              Radius.circular(16)),
          boxShadow: const [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.8,
                offset: Offset(0, 1)),
          ]),
      height: MediaQuery.of(context).size.height *
          0.15,
      width: MediaQuery.of(context).size.width *
          0.27,
    );
  }
}