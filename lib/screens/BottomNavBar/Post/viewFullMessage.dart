import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';

class ViewFullMessage extends StatefulWidget {
  final user_name;
  final post_text;
  final post_date;
  ViewFullMessage(
      {
        this.user_name,
        this.post_text,
        this.post_date,
      });

  @override
  _ViewFullMessageState createState() => _ViewFullMessageState();
}

class _ViewFullMessageState extends State<ViewFullMessage> {

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
            title: new Text('Post By'),
            subtitle: new Text(widget.user_name),
          ),
          Divider(),
          ListTile(
            title: new Text('Post Text'),
            subtitle: new Text(widget.post_text),
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('Post Date', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.post_date, style: TextStyle(color: CustomColors().secondaryColor),), )
            ],
          ),
        ],
      ),
    );
  }
}
