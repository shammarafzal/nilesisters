import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
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
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 42.0
    ..radius = 18.0
    ..progressColor = NgoPalette.primary
    ..backgroundColor = Colors.white
    ..indicatorColor = NgoPalette.primary
    ..textColor = NgoPalette.ink
    ..maskColor = NgoPalette.navy.withValues(alpha: 0.12)
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
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: NgoPalette.primary,
            brightness: Brightness.light,
          ).copyWith(
            primary: NgoPalette.primary,
            secondary: NgoPalette.secondary,
            surface: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            margin: EdgeInsets.zero,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: NgoPalette.sky,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: NgoPalette.primary.withValues(alpha: 0.15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: NgoPalette.primary.withValues(alpha: 0.10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: NgoPalette.primary, width: 1.3),
            ),
            labelStyle: const TextStyle(color: NgoPalette.muted, fontWeight: FontWeight.w600),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: NgoPalette.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: NgoPalette.primary,
            unselectedItemColor: NgoPalette.muted,
            type: BottomNavigationBarType.fixed,
            elevation: 16,
          ),
        ),
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
