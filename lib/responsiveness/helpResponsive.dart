import 'package:flutter/material.dart';

import 'package:pif_admin_dashboard/mobile/mobileHelp.dart';

import '../helpPage.dart';
import '../responsive.dart';

class helpResponsive extends StatelessWidget {
  const helpResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: help(), tablet: help(), mobile: mobileHelp(),
      ),
    );
  }
}
