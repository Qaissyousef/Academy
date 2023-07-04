import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/home.dart';
import 'package:pif_admin_dashboard/tablet/tabletHome.dart';

import '../mobile/mobileHome.dart';
import '../responsive.dart';

class HomeResponsive extends StatelessWidget {
  const HomeResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: home(), tablet: tabletHome(), mobile: mobileHome(),
      ),
    );
  }
}
