import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'Routes/route.dart';

bool isLoggedIn = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  HttpOverrides.global = new MyHttpOverrides();
  configLoading();
  runApp(MyApp());
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withValues(alpha: 0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale){
    final state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Locale? _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? '/home_page' : '/login',
        getPages: Routes.routes,
        locale: _locale,
        supportedLocales: const [
          Locale('en','US'),
          Locale('fa','IR'),
          Locale('ar','SA'),
          Locale('hi','IN'),
          Locale('fr','FR'),
          Locale('sw','KE'),
          Locale('am','ET'),

        ],
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        localeListResolutionCallback: (deviceLocale, supportedLocales){
          return _locale ?? supportedLocales.first;
        },
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
