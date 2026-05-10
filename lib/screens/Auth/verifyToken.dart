import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class VerifyToken extends StatefulWidget {
  @override
  _VerifyTokenState createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  TextEditingController _controller = TextEditingController(text: "");
  Timer? _timer;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Verify Token"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/nilesisters.png')),
                ),
              ),
              Center(
                child: Container(
                  width: 220,
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColors().secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {

                    await EasyLoading.show(
                      status: 'loading...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    var response = await Utils()
                        .checkForgotToken(_controller.text);
                    if (response['status'] == false) {
                      _timer?.cancel();
                      await EasyLoading.showError(
                          response['message']);
                    } else {
                      _timer?.cancel();
                      await EasyLoading.showSuccess(
                          response['message']);
                      Navigator.of(context)
                          .pushReplacementNamed('/new_password', arguments: {'token': _controller.text});
                    }

                  },
                  child:Text(
                    'Verify Token',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
