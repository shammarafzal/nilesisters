import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  String name,email,password;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Register"),
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
                  onChanged: (value){
                    name = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    //    hintText: 'Enter valid email id as abc@gmail.com'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    email = value;
                  },
                  //  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email / Phone',
                    // hintText: 'Enter secure password'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  onChanged: (value){
                    password = value;
                  },
                  //  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    final String RName = name;
                    final String RPassword = password;
                    final String Remail = email;
                    final String Rpic = "aaa";
                    if(RName != null && RPassword != null && Remail != null){
                      var url = Uri.https('nilesisters.codingoverflow.com', '/api/userregistration.php', {"q": "dart"});
                      final response = await http.post(url, body: {
                        "email": Remail,
                        "password": RPassword,
                        "image": Rpic,
                        "name": RName,
                      });
                      if (response.statusCode == 200) {
                        final String responseString = response.body;
                        if (responseString == 'Register Successfull'){
                          Fluttertoast.showToast(
                            msg: "Register Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          await Navigator.pushNamed(context, 'loginroute');
                        }
                        if(responseString == 'Already Registered'){
                          Fluttertoast.showToast(
                            msg: "Email Already Exist",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                        else{
                          Fluttertoast.showToast(
                            msg: "Error",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      }
                      else{
                        Fluttertoast.showToast(
                          msg: "API Response Error",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }

                    }
                    else {
                      Fluttertoast.showToast(
                        msg: "Please Fill Fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child:  Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'loginroute');
                },
                child: new Text("Already have an account? Login"),
              ),
              //Text('Already have an account? Login')
            ],
          ),
        ),
      ),
    );
  }
}
