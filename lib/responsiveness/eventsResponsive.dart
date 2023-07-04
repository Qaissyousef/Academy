import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/adminstration/events.dart';
import 'package:pif_admin_dashboard/mobile/mobileEvents.dart';

import '../responsive.dart';

class eventResponsive extends StatelessWidget {
  const eventResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: events(), tablet: events(), mobile: mobileEvents(),
      ),
    );
  }
}
