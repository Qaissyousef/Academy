import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/adminstration/users.dart';
import 'package:pif_admin_dashboard/mobile/mobileUsers.dart';

import '../responsive.dart';

class userResponsive extends StatelessWidget {
  const userResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: users(), tablet: users(), mobile: mobileUsers(),
      ),
    );
  }
}
