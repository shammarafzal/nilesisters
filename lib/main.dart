import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/screens/login_screen.dart';
import 'screens/signup.dart';
void main() {
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
        initialRoute: 'loginroute',
        routes: {
          'loginroute': (context)=> LoginDemo(),
          'signup_screen': (context)=>Signup(),
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

