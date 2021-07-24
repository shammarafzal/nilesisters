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
            subtitle: new Text(widget.address),
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Phone', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.phone, style: TextStyle(color: CustomColors().secondaryColor),), )
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Email', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.email, style: TextStyle(color: CustomColors().secondaryColor),), )
            ],
          ),
        ],
      ),
    );
  }
}
