import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getContact.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'contactDetails.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  _launchSanDiegoMap() async {
    const url =
        "https://www.google.com/maps/place/5532+El+Cajon+Blvd+%235,+San+Diego,+CA+92115,+USA/@32.7588005,-117.0776665,17z/data=!3m1!4b1!4m5!3m4!1s0x80d9569ee50c9e5f:0x13ac1399d3d79550!8m2!3d32.7588005!4d-117.0754778";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGlendaleMap() async {
    const url =
        "https://www.google.com/maps/place/100+N+Brand+Blvd+UNIT+219,+Glendale,+CA+91203,+USA/@34.1465191,-118.2569264,17z/data=!3m1!4b1!4m5!3m4!1s0x80c2c0ff8fc4bd21:0xd574952757c34cd3!8m2!3d34.1465191!4d-118.2547377";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchSanDiegoMailer() async {
    const url = "mailto:info@nilesisters.org";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGlendaleMailer() async {
    const url = "mailto:info.la@nilesisters.org";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchSanDiegoCaller() async {
    const url = "tel:+16192652959";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGlendaleCaller() async {
    const url = "tel:+18184035119";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL() async {
    const url = 'https://nilesisters.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  _launchCallerEnglish() async {
    const url = "tel:18007352922";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCallerSpanish() async {
    const url = "tel:18008553000";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




  _launchInsta1() async {
    const url =
        "https://www.instagram.com/womenshealth.nsdi/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchInsta2() async {
    const url =
        "https://www.instagram.com/learnmoresd/?hl=en";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchfb1() async {
    const url =
        "https://www.facebook.com/nilesisters";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchfb2() async {
    const url =
        "https://www.facebook.com/learnmoresd";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(DemoLocalization.of(context)
              .getTranslatedValue('contact_us')),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
              child: new Center(
                child: Text(
                  "Nile Sisters Development Initiative",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'San Diego Office',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('address'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),

                      ),
                      trailing: Container(
                        width: SizeConfig.screenWidth * 0.5,
                        child: Text(
                          '5532 El Cajon Blvd, San Diego, CA 92115, United States',
                          textAlign: TextAlign.end,
                          // softWrap: false,
                          style: TextStyle(fontSize: 16),
                          maxLines: 4,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('phone'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '+1 619-265-2959',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('email'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        'info@nilesisters.org',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchSanDiegoMap();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchSanDiegoCaller();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchSanDiegoMailer();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Glendale Office',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('address'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),

                      ),
                      trailing: Container(
                        width: SizeConfig.screenWidth * 0.5,
                        child: Text(
                          '100 North Brand Blvd., Suite 219 Glendale, CA 91203',
                          textAlign: TextAlign.end,
                          // softWrap: false,
                          style: TextStyle(fontSize: 16),
                          maxLines: 4,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('phone'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '+18184035119',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('email'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        'info.la@nilesisters.org',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchGlendaleMap();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchGlendaleCaller();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchGlendaleMailer();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // FutureBuilder<GetContact>(
            //     future:  Utils().fetchcontact(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return  ListView.builder(
            //         itemCount: snapshot.data.data.length,
            //         shrinkWrap: true,
            //         itemBuilder: (BuildContext context, index) {
            //           return InkWell(
            //             onTap: (){
            //               Navigator.push(
            //                 context,
            //                 new MaterialPageRoute(
            //                   builder: (context) => new ContactDetails(office_name: snapshot.data.data[index].officeName, address: snapshot.data.data[index].address, phone: snapshot.data.data[index].englishPhone, email: snapshot.data.data[index].email,),
            //                 ),
            //               );
            //             },
            //             child: Card(
            //               margin: EdgeInsets.all(10.0),
            //               child: Padding(
            //                 padding: EdgeInsets.all(12.0),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     Center(
            //                       child: Text(
            //                         snapshot.data.data[index].officeName,
            //                         style: TextStyle(
            //                             color: Colors.blue,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 24),
            //                       ),
            //                     ),
            //                     ListTile(
            //                       title: Text(
            //                         DemoLocalization.of(context)
            //                             .getTranslatedValue('address'),
            //                         style: TextStyle(
            //                             color: Colors.blue,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18),
            //                       ),
            //                       trailing: Container(
            //                         width: SizeConfig.screenWidth * 0.5,
            //                         child: Text(
            //                           snapshot.data.data[index].address,
            //                           overflow: TextOverflow.ellipsis,
            //                           textAlign: TextAlign.end,
            //                           // softWrap: false,
            //                           style: TextStyle(fontSize: 20),
            //                         ),
            //                       ),
            //                     ),
            //                     ListTile(
            //                       title: Text(
            //                         DemoLocalization.of(context)
            //                             .getTranslatedValue('phone'),
            //                         style: TextStyle(
            //                             color: Colors.blue,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18),
            //                       ),
            //                       trailing: Text(
            //                         snapshot.data.data[index].englishPhone,
            //                         style: TextStyle(fontSize: 16),
            //                       ),
            //                     ),
            //                     ListTile(
            //                       title: Text(
            //                         DemoLocalization.of(context)
            //                             .getTranslatedValue('email'),
            //                         style: TextStyle(
            //                             color: Colors.blue,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18),
            //                       ),
            //                       trailing: Text(
            //                         snapshot.data.data[index].email,
            //                         style: TextStyle(fontSize: 16),
            //                       ),
            //                     ),
            //                     // Row(
            //                     //   mainAxisAlignment: MainAxisAlignment
            //                     //       .spaceBetween,
            //                     //   children: [
            //                     //     CircleAvatar(
            //                     //       radius: 25,
            //                     //       backgroundColor: Colors.blue,
            //                     //       child: IconButton(
            //                     //         icon: Icon(
            //                     //           Icons.map,
            //                     //           color: Colors.white,
            //                     //         ),
            //                     //         onPressed: () async{
            //                     //           var url = '${snapshot.data.data[index].address}';
            //                     //           if (await canLaunch(url)) {
            //                     //           await launch(url);
            //                     //           } else {
            //                     //           throw 'Could not launch $url';
            //                     //           }
            //                     //         },
            //                     //       ),
            //                     //     ),
            //                     //     CircleAvatar(
            //                     //       radius: 25,
            //                     //       backgroundColor: Colors.blue,
            //                     //       child: IconButton(
            //                     //         icon: Icon(
            //                     //           Icons.phone,
            //                     //           color: Colors.white,
            //                     //         ),
            //                     //         onPressed: () async{
            //                     //           var url = snapshot.data.data[index].englishPhone;
            //                     //           if (await canLaunch(url)) {
            //                     //           await launch(url);
            //                     //           } else {
            //                     //           throw 'Could not launch $url';
            //                     //           }
            //                     //         },
            //                     //       ),
            //                     //     ),
            //                     //     CircleAvatar(
            //                     //       radius: 25,
            //                     //       backgroundColor: Colors.blue,
            //                     //       child: IconButton(
            //                     //         icon: Icon(
            //                     //           Icons.mail,
            //                     //           color: Colors.white,
            //                     //         ),
            //                     //         onPressed: () async{
            //                     //           var url = snapshot.data.data[index].email;
            //                     //           if (await canLaunch(url)) {
            //                     //           await launch(url);
            //                     //           } else {
            //                     //           throw 'Could not launch $url';
            //                     //           }
            //                     //         },
            //                     //       ),
            //                     //     ),
            //                     //   ],
            //                     // ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         }
            //         );
            //       }
            //       return Center(
            //        );
            //     }
            // ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'TTY Users',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('english'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '1 800-735-2922',
                        // style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('spanish'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        '+1 800-855-3000',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerEnglish();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchCallerSpanish();
                            },
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('english'),
                        style: TextStyle(
                            color: Colors.grey,
                            ),
                      ),
                      trailing: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('spanish'),
                        style: TextStyle(color: Colors.grey,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('social_networks'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('website'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: InkWell(
                        onTap: (){
                          _launchURL();
                        },
                        child: Text(
                          'www.nilesisters.org',
                          // style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Text('SD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),textAlign: TextAlign.right,),
                        Text('L.M', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),textAlign: TextAlign.left,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.facebook_square,
                              color: Colors.white,
                            ),
                            onPressed: () {
                             _launchfb1();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.facebook_square,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchfb2();
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('NS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),textAlign: TextAlign.right,),
                        Text('L.M', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),textAlign: TextAlign.left,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.instagram,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchInsta1();
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              FontAwesome.instagram,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _launchInsta2();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
