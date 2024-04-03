import 'package:flutter/material.dart';

class FractionalStar extends StatelessWidget {
  final double value;

  FractionalStar(this.value);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.star,
          color: Colors.grey, // Unfilled color
          size: 15,
        ),
        ClipRect(
          clipper: MyClipper(value),
          child: Icon(
            Icons.star,
            color: Colors.amber, // Filled color
            size: 15,
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final double value;

  MyClipper(this.value);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * value, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}




