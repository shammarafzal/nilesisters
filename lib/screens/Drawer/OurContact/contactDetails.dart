import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactDetails extends StatefulWidget {
  final office_name;
  final address;
  final phone;
  final email;
  ContactDetails(
      {
        this.office_name,
        this.address,
        this.phone,
        this.email,
      });

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Nilesisters'),
      ),
      body: new ListView(
        children: <Widget>[
          ListTile(
            title: new Text('Office name'),
            subtitle: new Text(widget.office_name),
          ),
          Divider(),
          ListTile(
            title: new Text('Address'),
            subtitle: InkWell(
                onTap: (){
                  if(widget.office_name == "San Diego Office"){
                    _launchSanDiegoMap();
                  }
                  else{
                    _launchGlendaleMap();
                  }
                },
                child: new Text(widget.address)),
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Phone', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: (){
                      if(widget.office_name == "San Diego Office"){
                        _launchSanDiegoCaller();
                      }
                      else{
                        _launchGlendaleCaller();
                      }
                    },
                    child: new Text(widget.phone, style: TextStyle(color: CustomColors().secondaryColor),)), )
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Email', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: (){
                        if(widget.office_name == "San Diego Office"){
                          _launchSanDiegoMailer();
                        }
                        else{
                          _launchGlendaleMailer();
                        }
                    },
                    child: new Text(widget.email, style: TextStyle(color: CustomColors().secondaryColor),)), )
            ],
          ),
        ],
      ),
    );
  }
}
