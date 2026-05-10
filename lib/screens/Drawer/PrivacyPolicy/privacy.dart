import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nilesisters/Localization/demo_localization.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}
class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://nilesisters.org/privacy-policy/'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(DemoLocalization.of(context)
              .getTranslatedValue('privacy_policy')),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
