import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/screens/HomePage.dart';
import 'package:nilesisters/screens/login_screen.dart';
import 'package:nilesisters/screens/verifyToken.dart';


class alertScreen{
  showAlertDialog(BuildContext context,String msg) {
    Timer timer = Timer(Duration(milliseconds: 1000), (){
      Navigator.of(context, rootNavigator: true).pop();
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: new Text("Nilesisters",style: TextStyle(fontSize: 20,color:CustomColors().redicon,),),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(msg,style: TextStyle(fontSize: 14,color: CustomColors().buttonTextColor,),textAlign: TextAlign.center,),
            ),
          ),
        )
    ).then((value){
      timer.cancel();
      timer = null;
    });
  }
  showSignupAlertDialog(BuildContext context,String msg) {
    Timer timer = Timer(Duration(milliseconds: 1000), (){
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new LoginDemo(),
        ),
      );
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: new Text("Nilesisters",style: TextStyle(fontSize: 20,color: CustomColors().redicon,),),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(msg,style: TextStyle(fontSize: 14,color: CustomColors().buttonTextColor,),textAlign: TextAlign.center,),
            ),
          ),
        )
    ).then((value){
      timer.cancel();
      timer = null;
    });
  }
  showSigninAlertDialog(BuildContext context,String msg) {
    Timer timer = Timer(Duration(milliseconds: 1000), (){
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new HomePage(),
        ),
      );
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: new Text("Nilesisters",style: TextStyle(fontSize: 20,color: CustomColors().redicon,),),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(msg,style: TextStyle(fontSize: 14,color: CustomColors().buttonTextColor,),textAlign: TextAlign.center,),
            ),
          ),
        )
    ).then((value){
      timer.cancel();
      timer = null;
    });
  }
  showForgotAlertDialog(BuildContext context,String msg) {
    Timer timer = Timer(Duration(milliseconds: 1000), (){
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new VerifyToken(),
        ),
      );
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: new Text("Nilesisters",style: TextStyle(fontSize: 20,color: CustomColors().redicon,),),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(msg,style: TextStyle(fontSize: 14,color:CustomColors().buttonTextColor,),textAlign: TextAlign.center,),
            ),
          ),
        )
    ).then((value){
      timer.cancel();
      timer = null;
    });
  }
}