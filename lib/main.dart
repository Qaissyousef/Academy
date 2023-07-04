import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pif_admin_dashboard/login.dart';
import 'package:pif_admin_dashboard/mobile/mobileLogin.dart';
import 'package:pif_admin_dashboard/responsive.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  runApp(EasyLocalization(
    supportedLocales: [
      Locale("en"),
      Locale("ar"),
    ],
    path: 'assets/languages',
    saveLocale: true,
    fallbackLocale: Locale('en'),
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PIF Academy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(

          primary:  Color(0xff215732),
          secondary:  Color(0xff215732),



        ),

      ),

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales ,
      locale: context.locale,

      home:  MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: loginPage(), mobile: mobileLogin(), tablet: mobileLogin(),
      ),
    );
  }
}