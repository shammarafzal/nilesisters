import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nilesisters/utils/Utils.dart';

import 'alertDialog.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool  _validatePassword = false;
  bool emailValid = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Register"),
          automaticallyImplyLeading: false,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  //  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  controller: _confirmpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: 'Enter secure password',
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text);
                    if(_name.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Name");
                    }
                    else if(_email.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Email");
                    }
                    else if(emailValid == false){
                      alertScreen().showAlertDialog(context, "Please Enter Valid Email");
                    }
                    else if(_password.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Password");
                    }
                    else if(_password.text.length <= 7 ){
                      alertScreen().showAlertDialog(context, "Password Length Must Greater than 8");
                    }
                    else if(_confirmpassword.text == ""){
                      alertScreen().showAlertDialog(context, "Please Enter Confirm Password");
                    }
                    else if(_confirmpassword.text.length <= 7 ){
                      alertScreen().showAlertDialog(context, "Confirm Password Length Must Greater than 8");
                    }
                    else if(_password.text  !=  _confirmpassword.text){
                      alertScreen().showAlertDialog(context, "Password Does Not Match");
                    }
                    else{
                      isLoading = true;
                      var response = await Utils().register(_name.text, _email.text, _password.text, _confirmpassword.text);
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
                        await alertScreen().showSignupAlertDialog(context, "Registered Successfully");
                      }
                    }
                  },
                  child: isLoading
                      ? Center(
                    child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                  )
                      :Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'loginroute');
                },
                child: new RichText(
                  text: TextSpan(
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children:[
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(text: 'Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
              //Text('Already have an account? Login')
            ],
          ),
        ),
      ),
    );
  }
}
