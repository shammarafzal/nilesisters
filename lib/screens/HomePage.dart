import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getUser.dart';
import 'package:nilesisters/classes/language.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/main.dart';
import 'package:nilesisters/screens/Drawer/ContactUs/contact.dart';
import 'package:nilesisters/screens/Drawer/OurContact/contactUs.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/eventsViewer.dart';
import 'package:nilesisters/screens/BottomNavBar/News/home.dart';
import 'package:nilesisters/screens/BottomNavBar/Resources/pdfview.dart';
import 'package:nilesisters/screens/Drawer/PrivacyPolicy/privacy.dart';
import 'package:nilesisters/screens/Drawer/Videos/videosViewer.dart';
import 'package:nilesisters/screens/Drawer/About/founder.dart';
import 'package:nilesisters/screens/Drawer/Staff/staff.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'BottomNavBar/Maps/mapsViewClass.dart';
import 'BottomNavBar/Post/showuserposts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timer;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Community',
      style: optionStyle,
    ),
    Text(
      'Index 3: Events',
      style: optionStyle,
    ),
    Text(
      'Index 4: Map',
      style: optionStyle,
    ),
    Text(
      'Index 5: Resources',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    void _changeLanguage(Language language) {
      Locale _temp;
      switch (language.languageCode) {
        case 'en':
          _temp = Locale(language.languageCode, 'US');
          break;
        case 'fa':
          _temp = Locale(language.languageCode, 'IR');
          break;
        case 'ar':
          _temp = Locale(language.languageCode, 'SA');
          break;
        case 'hi':
          _temp = Locale(language.languageCode, 'IN');
          break;
        case 'fr':
          _temp = Locale(language.languageCode, 'FR');
          break;
        case 'sw':
          _temp = Locale(language.languageCode, 'KE');
          break;
        case 'am':
          _temp = Locale(language.languageCode, 'ET');
          break;
        default:
          _temp = Locale(language.languageCode, 'US');
      }
      MyApp.setLocale(context, _temp);
    }

    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text('Nile Sisters'),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton(
                  onChanged: (Language language) {
                    _changeLanguage(language);
                  },
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Text(lang.name),
                        ],
                      )))
                      .toList()),
            ),
          ],
        ),
        drawer: new Drawer(
          child: ListView(
                    children: <Widget>[
                      FutureBuilder<GetUser>(
                        future:  Utils().fetchuser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return UserAccountsDrawerHeader(
                              currentAccountPicture: GestureDetector(
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  backgroundImage: NetworkImage(
                                      Utils().image_base_url+'${snapshot.data.user.image}'),
                                ),
                              ),
                              accountName: Text(snapshot.data.user.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              accountEmail: Text(snapshot.data.user.email),
                              decoration: new BoxDecoration(color: Colors.blue),

                            );
                          }
                          return UserAccountsDrawerHeader(
                            currentAccountPicture: GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(
                                    'https://himdeve.eu/wp-content/uploads/2019/04/logo_retina.png'),
                              ),
                            ),
                            accountName: Text('Nilesisters Default',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            accountEmail: Text('nilesistesdefault'),
                            decoration: new BoxDecoration(color: Colors.blue),
                          );
                        }
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new founder()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('home')),
                          leading: Icon(Icons.home, color: Colors.green),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new StaffViewer()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('staff')),
                          leading: Icon(Icons.person, color: Colors.red),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ContactUs()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('contact_us')),
                          leading: Icon(Icons.contact_phone, color: Colors.blue),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Contact()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('message_us')),
                          leading: Icon(Icons.message, color: Colors.blue),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new PrivacyPolicy()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('privacy_policy')),
                          leading: Icon(Icons.policy, color: Colors.green),
                        ),
                      ),
                      Divider(),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new VideoViewer()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('videos')),
                          leading:
                          Icon(Icons.videocam_sharp, color: Colors.green),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences
                              .getInstance();
                          try {
                            _timer?.cancel();
                            await EasyLoading.showSuccess('Successfuly Logged Out');
                              prefs.remove("token");
                              prefs.remove("isLoggedIn");
                              Navigator.of(context).pushReplacementNamed('/login');
                            // var response =
                            // await Utils().logout();
                            // print(response);
                            // if (response['status'] == false) {
                            //   _timer?.cancel();
                            //   await EasyLoading.showError(
                            //       response['message']);
                            // } else {
                            //   _timer?.cancel();
                            //   await EasyLoading.showSuccess(
                            //       response['message']);
                            //   prefs.remove("token");
                            //   prefs.remove("isLoggedIn");
                            //   Navigator.of(context).pushReplacementNamed('/login');
                            // }
                          }
                          catch (e) {
                            _timer?.cancel();
                            await EasyLoading.showError(
                                e.toString());
                          }
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('logout')),
                          leading: Icon(Icons.logout, color: Colors.green),
                        ),
                      ),
                    ],
                  )
          ),
        body: new IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            new Home(),
            ShowPosts(),
            new PdfViewer(),
            new EventsViewer(),
            new MapPage(),

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.backup_table),
              label: 'Resources',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),

          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          unselectedItemColor: Colors.blue,
        ),
      ),
    );
  }
}
