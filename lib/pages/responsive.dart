import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? smallScreen;
  final Widget? mediumScreen;
  final Widget? mediumScreen1;
  final Widget largeScreen;

  const Responsive(
      {Key? key,
      this.smallScreen,
      this.mediumScreen,
      this.mediumScreen1,
      required this.largeScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width <= 810;
  }

  static bool isMediumScreen1(BuildContext context) {
    return MediaQuery.of(context).size.width >= 2880 &&
    
        MediaQuery.of(context).size.width <= 1400;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1920;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1400) {
        return largeScreen;
      } else if (constraints.maxWidth <= 1200 && constraints.maxWidth <= 600) {
        return mediumScreen ?? largeScreen;
      } else if (constraints.maxWidth <= 1200 && constraints.maxWidth <= 600) {
        return mediumScreen ?? largeScreen;
      } else {
        return smallScreen ?? largeScreen;
      }
    });
  }
}
