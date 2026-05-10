import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/classes/language.dart';
import 'package:nilesisters/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void changeLanguage(Language language) {
      late final Locale locale;
      switch (language.languageCode) {
        case 'en':
          locale = const Locale('en', 'US');
          break;
        case 'fa':
          locale = const Locale('fa', 'IR');
          break;
        case 'ar':
          locale = const Locale('ar', 'SA');
          break;
        case 'hi':
          locale = const Locale('hi', 'IN');
          break;
        case 'fr':
          locale = const Locale('fr', 'FR');
          break;
        case 'sw':
          locale = const Locale('sw', 'KE');
          break;
        case 'am':
          locale = const Locale('am', 'ET');
          break;
        default:
          locale = const Locale('en', 'US');
      }
      MyApp.setLocale(context, locale);
    }

    return NgoPageShell(
      title: 'Settings',
      subtitle: 'Customize your experience and preferences.',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const NgoSectionHeader(
            title: 'Localization',
            subtitle: 'Choose your preferred language for the application.',
          ),
          const SizedBox(height: 16),
          NgoCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: Language.languageList().map((lang) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: NgoPalette.sky,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.language_rounded, color: NgoPalette.primary),
                  ),
                  title: Text(
                    lang.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: NgoPalette.ink,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded, color: NgoPalette.muted),
                  onTap: () {
                    changeLanguage(lang);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Language changed to ${lang.name}'),
                        backgroundColor: NgoPalette.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 30),
          const NgoSectionHeader(
            title: 'App Information',
            subtitle: 'Details about the current version and build.',
          ),
          const SizedBox(height: 16),
          NgoCard(
            child: Column(
              children: [
                _infoRow(context, 'Version', '1.0.0'),
                const Divider(height: 24),
                _infoRow(context, 'Build Number', '1'),
                const Divider(height: 24),
                _infoRow(context, 'Release Date', 'May 2026'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, color: NgoPalette.ink),
        ),
        Text(
          value,
          style: const TextStyle(color: NgoPalette.muted, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
