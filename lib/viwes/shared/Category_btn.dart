import 'package:flutter/material.dart';

import 'appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {Key? key, required this.buttoncolor, required this.lable, this.onpress})
      : super(key: key);
  final Color buttoncolor;
  final String lable;
  final void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.250,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: buttoncolor, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Center(
            child: Text(
          lable,
          style: appstyle(15, buttoncolor, FontWeight.w600),
        )),
      ),
    );
  }
}
