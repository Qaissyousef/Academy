import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;

  final Widget tablet;

  final Widget desktop;


  const Responsive({

    required this.mobile,

    required this.tablet,

    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 375;


  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 375;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return desktop;
        }

        else if (constraints.maxWidth == 1024){
          return tablet;
        }

        else {
          return mobile;
        }
      },
    );
  }
}