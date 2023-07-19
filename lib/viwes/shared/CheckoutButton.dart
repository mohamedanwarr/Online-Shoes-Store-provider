import 'package:flutter/material.dart';

import 'appstyle.dart';
class CheackoutButton extends StatelessWidget {
  const CheackoutButton({
    super.key, required this.title, required this.ontap,
  });
  final String title;
 final void Function()?ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding:const EdgeInsets.all( 8) ,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          height: 50,
          width: MediaQuery.of(context ).size.width*0.9,
          child: Center(
            child: Text(title,style: appstyle(18,Colors.white,FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
