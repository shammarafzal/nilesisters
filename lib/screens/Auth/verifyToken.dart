import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class VerifyToken extends StatefulWidget {
  @override
  _VerifyTokenState createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  TextEditingController _controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage;
  Timer _timer;
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
                  height: 100.0,
                  child: PinCodeTextField(
                    autofocus: true,
                    controller: _controller,
                    hideCharacter: true,
                    highlight: true,
                    highlightColor: CustomColors().secondaryColor,
                    defaultBorderColor: CustomColors().secondaryColor,
                    hasTextBorderColor: CustomColors().secondaryColor,
                    maxLength: pinLength,
                    hasError: hasError,
                    maskCharacter: "*",
                    onTextChanged: (text) {
                      setState(() {
                        hasError = false;
                      });
                    },
                    pinBoxWidth: 50,
                    pinBoxHeight: 64,
                    hasUnderline: true,
                    wrapAlignment: WrapAlignment.spaceAround,
                    pinBoxDecoration:
                    ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextStyle: TextStyle(fontSize: 22.0, color: CustomColors().secondaryColor),
                    pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                    pinTextAnimatedSwitcherDuration:
                    Duration(milliseconds: 300),
                    highlightAnimationBeginColor: CustomColors().secondaryColor,
                    highlightAnimationEndColor: CustomColors().secondaryColor,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
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
