import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nilesisters/API_Data/getHome.dart';
import 'package:nilesisters/screens/SizeConfig.dart';
import 'package:nilesisters/screens/pdf_api.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final Completer <WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: fetchHome(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  GetHomePage hm = snapshot.data[index];
                  return Column(
                    children: [
                      Image.network(
                        ''+ hm.image,
                        height: 300,
                        width: SizeConfig.screenWidth * 1,
                      ),
                      Text(hm.news, style: TextStyle(fontSize: 16),)
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(216, 56, 48, 1)),
              ),
            );
          },
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
