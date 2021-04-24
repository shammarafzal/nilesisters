import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/users.dart';
import 'package:nilesisters/classes/language.dart';
import 'package:nilesisters/localization/demo_localization.dart';
import 'package:nilesisters/main.dart';
import 'package:nilesisters/screens/chat.dart';
import 'package:nilesisters/screens/contactUs.dart';
import 'package:nilesisters/screens/eventsViewer.dart';
import 'package:nilesisters/screens/home.dart';
import 'package:nilesisters/screens/mapView.dart';
import 'package:nilesisters/screens/pdfview.dart';
import 'package:nilesisters/screens/privacy.dart';
import 'package:nilesisters/screens/videosViewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nilesisters/screens/founder.dart';
import 'package:nilesisters/screens/staff.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String text;

  HomePage({Key key, @required this.text}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Users user;
  String email;

  String image;

  String name;

  getUsers() async {
    var url =
    Uri.https('nilesisters.codingoverflow.com', '/api/getusers.php', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": widget.text,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      List<dynamic> list = json.decode(responseString);
      user = Users.fromJson(list[0]);
      email = user.email;
      image = user.image;
      name = user.name;
      return user;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

//
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
      'Index 2: Events',
      style: optionStyle,
    ),
    Text(
      'Index 2: Map',
      style: optionStyle,
    ),
    Text(
      'Index 2: Pdf',
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
    setState(() async* {
      getUsers();
    });
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
                          Text(lang.flag),
                          Text(lang.name),
                        ],
                      )))
                      .toList()),
            ),
          ],
        ),
        drawer: new Drawer(
          child: FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: <Widget>[
                      new UserAccountsDrawerHeader(
                        accountName: Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        accountEmail: Text(email),
                        decoration: new BoxDecoration(color: Colors.blue),
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
                                  builder: (context) => new Staff()));
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
                          Share.share(
                              'https://play.google.com/store/apps/details?id=com.codingoverflow.nilesisters');
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('share')),
                          leading: Icon(Icons.share, color: Colors.blue),
                        ),
                      ),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new MyApp()));
                        },
                        child: ListTile(
                          title: Text(DemoLocalization.of(context)
                              .getTranslatedValue('logout')),
                          leading: Icon(Icons.logout, color: Colors.green),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              }
          ),
        ),
        body: new IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            new Home(),
            new Chat_Screen(),
            new EventsViewer(),
            new mapView(),
            new PdfViewer(),
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
              icon: Icon(Icons.event),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf),
              label: 'Pdf',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          unselectedItemColor: Colors.blue,
        ),
      ),
    );
  }
}
