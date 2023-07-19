import 'package:flutter/material.dart';
class BottomNavigsteBar extends StatelessWidget {
   const BottomNavigsteBar({
    super.key, this.onTap, required this.icon,
  });
final IconData icon;
final void Function() ?onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
