import 'package:flutter/material.dart';
import '../faq.dart';
import '../responsive.dart';

class faqResponsive extends StatelessWidget {
  const faqResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: faq(), tablet: faq(), mobile: faq(),
      ),
    );
  }
}
