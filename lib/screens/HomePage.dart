import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getUser.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/classes/language.dart';
import 'package:nilesisters/main.dart';
import 'package:nilesisters/screens/BottomNavBar/Events/eventsViewer.dart';
import 'package:nilesisters/screens/BottomNavBar/Maps/mapsViewClass.dart';
import 'package:nilesisters/screens/BottomNavBar/News/home.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/showuserposts.dart';
import 'package:nilesisters/screens/BottomNavBar/Resources/pdfview.dart';
import 'package:nilesisters/screens/Drawer/About/about.dart';
import 'package:nilesisters/screens/Drawer/ContactUs/contact.dart';
import 'package:nilesisters/screens/Drawer/OurContact/contactUs.dart';
import 'package:nilesisters/screens/Drawer/PrivacyPolicy/privacy.dart';
import 'package:nilesisters/screens/Drawer/Staff/staff.dart';
import 'package:nilesisters/screens/Drawer/Videos/videosViewer.dart';
import 'package:nilesisters/screens/Drawer/settings.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:nilesisters/utils/navigation_controller.dart';
import 'package:nilesisters/Settings/ngo_nav_bar.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  final NavigationController navBarController = Get.put(NavigationController(), permanent: true);

  void _onItemTapped(int index) {
    navBarController.setIndexSilently(index);
    setState(() {});
  }

  String _getAppBarTitle() {
    switch (navBarController.selectedIndex) {
      case 0:
        return DemoLocalization.of(context).getTranslatedValue('home') ?? 'Nile Sisters';
      case 1:
        return DemoLocalization.of(context).getTranslatedValue('community') ?? 'Community';
      case 2:
        return DemoLocalization.of(context).getTranslatedValue('resources') ?? 'Resources';
      case 3:
        return DemoLocalization.of(context).getTranslatedValue('events') ?? 'Events';
      case 4:
        return DemoLocalization.of(context).getTranslatedValue('map') ?? 'Map';
      case 5:
        return DemoLocalization.of(context).getTranslatedValue('staff') ?? 'Staff';
      default:
        return 'Nile Sisters';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildDrawerHeader(GetUser user) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(gradient: NgoPalette.heroGradient),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nile Sisters',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user.user.name,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.user.email,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.88), fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget drawerItem({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            leading: Icon(icon, color: NgoPalette.primary),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: NgoPalette.ink)),
            trailing: const Icon(Icons.chevron_right_rounded, color: NgoPalette.muted),
            onTap: onTap,
          ),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      drawer: Drawer(
        backgroundColor: const Color(0xFFF6FAFF),
        child: FutureBuilder<GetUser>(
          future: Utils().fetchuser(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                if (snapshot.hasData && user != null) buildDrawerHeader(user) else Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(gradient: NgoPalette.heroGradient),
                  child: const SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white24,
                          child: Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 30),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Nile Sisters',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                drawerItem(
                  icon: Icons.home_rounded,
                  title: DemoLocalization.of(context).getTranslatedValue('home'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _onItemTapped(0);
                  },
                ),
                drawerItem(
                  icon: Icons.person_rounded,
                  title: DemoLocalization.of(context).getTranslatedValue('founder'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _onItemTapped(0);
                  },
                ),
                drawerItem(
                  icon: Icons.people_alt_rounded,
                  title: DemoLocalization.of(context).getTranslatedValue('staff'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _onItemTapped(5);
                  },
                ),
                drawerItem(
                  icon: Icons.phone_in_talk_rounded,
                  title: 'Our Offices',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ContactUs()));
                  },
                ),
                drawerItem(
                  icon: Icons.mail_outline_rounded,
                  title: DemoLocalization.of(context).getTranslatedValue('message_us'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Contact()));
                  },
                ),
                drawerItem(
                  icon: Icons.policy_rounded,
                  title: DemoLocalization.of(context).getTranslatedValue('privacy_policy'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PrivacyPolicy()));
                  },
                ),
                drawerItem(
                  icon: Icons.play_circle_outline_rounded,
                  title: DemoLocalization.of(context).getTranslatedValue('videos'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => VideoViewer()));
                  },
                ),
                drawerItem(
                  icon: Icons.settings_rounded,
                  title: 'Settings',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                  },
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: NgoCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          gradient: NgoPalette.heroGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.logout_rounded, color: Colors.white),
                      ),
                      title: const Text('Sign out', style: TextStyle(fontWeight: FontWeight.w800, color: NgoPalette.ink)),
                      subtitle: const Text('Leave the current session', style: TextStyle(color: NgoPalette.muted)),
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        try {
                          _timer?.cancel();
                          await EasyLoading.showSuccess('Successfully logged out');
                          await prefs.remove('token');
                          await prefs.remove('isLoggedIn');
                          if (mounted) {
                            Navigator.of(context).pushReplacementNamed('/login');
                          }
                        } catch (e) {
                          _timer?.cancel();
                          await EasyLoading.showError(e.toString());
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF6FAFF),
            child: Obx(() => IndexedStack(
              index: navBarController.selectedIndex,
              children: [
                founder(),
                ShowPosts(),
                PdfViewer(),
                EventsViewer(),
                MapPage(),
                StaffViewer(),
              ],
            )),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.dashboard_rounded, color: NgoPalette.navy),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  tooltip: 'Open Menu',
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NgoBottomNavBar(),
    );
  }
}
