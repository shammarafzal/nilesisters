import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return NgoPageShell(
      title: 'Our Offices',
      subtitle: 'Official locations and community network.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
        children: [
          const Text(
            'Official Offices',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: NgoPalette.ink,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Visit us at our regional hubs in San Diego and Glendale.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF8E8E93),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          
          _officeSection(
            'San Diego Office',
            '5532 El Cajon Blvd, San Diego, CA 92115',
            '+1 619-265-2959',
            'info@nilesisters.org',
            'https://www.google.com/maps/place/5532+El+Cajon+Blvd+%235,+San+Diego,+CA+92115',
          ),
          
          const SizedBox(height: 24),
          
          _officeSection(
            'Glendale Office',
            '100 North Brand Blvd., Suite 219, Glendale, CA 91203',
            '+1 818-403-5119',
            'info.la@nilesisters.org',
            'https://www.google.com/maps/place/100+N+Brand+Blvd+UNIT+219,+Glendale,+CA+91203',
          ),

          const SizedBox(height: 48),
          _sectionDivider('Accessibility'),
          const SizedBox(height: 24),
          
          _ttySection(),

          const SizedBox(height: 48),
          _sectionDivider('Social Networks'),
          const SizedBox(height: 24),
          
          _socialSection(),
        ],
      ),
    );
  }

  Widget _sectionDivider(String title) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: NgoPalette.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1.5)),
      ],
    );
  }

  Widget _officeSection(String name, String address, String phone, String email, String mapUrl) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: NgoPalette.ink),
          ),
          const SizedBox(height: 16),
          _infoRow(Icons.location_on_rounded, address),
          const SizedBox(height: 12),
          _infoRow(Icons.phone_rounded, phone),
          const SizedBox(height: 12),
          _infoRow(Icons.mail_rounded, email),
          const SizedBox(height: 24),
          Row(
            children: [
              _actionBtn(Icons.map_rounded, 'Map', () => _launchUrl(mapUrl)),
              const SizedBox(width: 12),
              _actionBtn(Icons.call_rounded, 'Call', () => _launchUrl('tel:${phone.replaceAll(' ', '')}')),
              const SizedBox(width: 12),
              _actionBtn(Icons.mail_rounded, 'Email', () => _launchUrl('mailto:$email')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ttySection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TTY Users',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: NgoPalette.ink),
          ),
          const SizedBox(height: 16),
          _ttyRow('English', '1 800-735-2922', () => _launchUrl('tel:18007352922')),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _ttyRow('Spanish', '+1 800-855-3000', () => _launchUrl('tel:18008553000')),
        ],
      ),
    );
  }

  Widget _socialSection() {
    return Column(
      children: [
        _socialTile('Official Website', 'www.nilesisters.org', Icons.language_rounded, () => _launchUrl('https://nilesisters.org/')),
        const SizedBox(height: 12),
        Row(
          children: [
            _socialIconBtn(FontAwesomeIcons.facebookSquare, 'Facebook SD', () => _launchUrl('https://www.facebook.com/nilesisters')),
            const SizedBox(width: 12),
            _socialIconBtn(FontAwesomeIcons.facebookSquare, 'Facebook LM', () => _launchUrl('https://www.facebook.com/learnmoresd')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _socialIconBtn(FontAwesomeIcons.instagram, 'Instagram NS', () => _launchUrl('https://www.instagram.com/womenshealth.nsdi/')),
            const SizedBox(width: 12),
            _socialIconBtn(FontAwesomeIcons.instagram, 'Instagram LM', () => _launchUrl('https://www.instagram.com/learnmoresd/')),
          ],
        ),
      ],
    );
  }

  Widget _socialTile(String label, String value, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: NgoPalette.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF8E8E93))),
                  const SizedBox(height: 2),
                  Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: NgoPalette.ink)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _socialIconBtn(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: NgoPalette.primary, size: 24),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: NgoPalette.ink)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: NgoPalette.primary.withValues(alpha: 0.6)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, color: NgoPalette.ink, fontWeight: FontWeight.w500, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _ttyRow(String label, String value, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF8E8E93))),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: NgoPalette.ink)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.phone_rounded, color: NgoPalette.primary),
          onPressed: onTap,
        ),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: NgoPalette.sky,
          foregroundColor: NgoPalette.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
