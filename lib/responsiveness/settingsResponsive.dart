import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/mobile/mobileSettings.dart';
import 'package:pif_admin_dashboard/settings.dart';

import '../responsive.dart';

class settingResponsive extends StatelessWidget {

  const settingResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: settings(), tablet: settings(), mobile: mobileSettings(),
      ),
    );
  }
}
