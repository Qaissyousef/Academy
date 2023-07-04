import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/messages.dart';
import 'package:pif_admin_dashboard/mobile/mobileMessages.dart';

import '../responsive.dart';

class MessageResponsive extends StatelessWidget {
  const MessageResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: messages(), tablet: messages(), mobile: mobileMessage(),
      ),
    );
  }
}
