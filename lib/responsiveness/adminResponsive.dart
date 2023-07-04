import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/administration.dart';
import 'package:pif_admin_dashboard/mobile/mobileadmin.dart';

import '../responsive.dart';

class adminResponsive extends StatelessWidget {
  const adminResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: adminstration(), tablet: adminstration(), mobile: adminMobile(),
      ),
    );
  }
}
