import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final Completer <WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
           children: [
             Image.asset('assets/images/nilesisters.png'),

           ],
        ),
      ),
      // body: WebView(
      //   initialUrl: 'https://nilesisters.org/',
      //   onWebViewCreated: (WebViewController webViewController){
      //     _controller.complete(webViewController);
      //   },
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
