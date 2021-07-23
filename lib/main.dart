import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/screens/HomePage.dart';
import 'package:nilesisters/screens/Auth/forgotPassword.dart';
import 'package:nilesisters/screens/Auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Auth/signup.dart';
var isLoggedIn;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
   isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');

  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? 'homePage' : 'loginroute',
        routes: {
          'loginroute': (context)=> LoginDemo(),
          'signup_screen': (context)=>Signup(),
          'forgotPassword': (context)=>ForgotPassword(),
          'homePage' : (context)=>HomePage(),
        } ,
        locale: _locale,
        supportedLocales: [
          Locale('en','US'),
          Locale('fa','IR'),
          Locale('ar','SA'),
          Locale('hi','IN'),
          Locale('fr','FR'),
          Locale('sw','KE'),
          Locale('am','ET'),

        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        localeListResolutionCallback: (deviceLocale, supportedLocales){
          if (_locale == null) {
            return supportedLocales.first;
          }
        }
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}