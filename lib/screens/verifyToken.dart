import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'alertDialog.dart';
import 'newPassword.dart';

class VerifyToken extends StatefulWidget {
  @override
  _VerifyTokenState createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  bool isLoading = false;
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage;
  @override
  void dispose() {
    controller.dispose();
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
                    controller: controller,
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
                    if(controller.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Pin");
                    }
                    else{
                      isLoading = true;
                      var response = await Utils().checkForgotToken(controller.text);
                      if(response['status'] == false){
                        setState(() {
                          isLoading = false;
                        });
                        alertScreen().showAlertDialog(context, response['message']);
                      }
                      else{
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new NewPassword(token: controller.text,),
                          ),
                        );
                      }
                    }
                  },
                  child: isLoading
                      ? Center(
                    child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                  )
                      :Text(
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
