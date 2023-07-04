import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/admission.dart';
import 'package:pif_admin_dashboard/mobile/mobileAdmission.dart';

import '../responsive.dart';

class admissionResponsive extends StatefulWidget {
  const admissionResponsive({Key? key}) : super(key: key);

  @override
  State<admissionResponsive> createState() => _admissionResponsiveState();
}

class _admissionResponsiveState extends State<admissionResponsive> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: admissionPage(), tablet: admissionPage(), mobile: mobileAdmissions(),
      ),
    );
  }
}
