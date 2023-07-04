import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/adminstration/announcements.dart';
import 'package:pif_admin_dashboard/mobile/courseDetails/mobileAnnouncements.dart';

import '../responsive.dart';

class announcementResponsive extends StatelessWidget {
  const announcementResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: announcements(), tablet: announcements(), mobile: mobileAnnouncements(),
      ),
    );
  }
}
