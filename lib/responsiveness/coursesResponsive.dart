import 'package:flutter/material.dart';

import 'package:pif_admin_dashboard/mobile/mobileCourses.dart';

import '../coursePage.dart';
import '../responsive.dart';

class courseResponsive extends StatelessWidget {
  const courseResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: coursesPage(), tablet: coursesPage(), mobile: mobileCourses(),
      ),
    );
  }
}
