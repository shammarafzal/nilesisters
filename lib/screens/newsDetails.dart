import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';

class NewsDetails extends StatefulWidget {
  final news_detail_name;
  final news_detail_category;
  final news_detail_text;
  final news_detail_image;
  final news_detail_date;
  NewsDetails(
      {
        this.news_detail_name,
        this.news_detail_category,
        this.news_detail_text,
        this.news_detail_image,
        this.news_detail_date,
      });

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

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
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: CustomColors().buttonTextColor,
                child: Image.network(widget.news_detail_image),
              ),
              footer: new Container(
                color: CustomColors().offwhite,
                child: ListTile(
                  leading: new Text(widget.news_detail_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0)),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: new Text(
                      widget.news_detail_category,
                      style: TextStyle(
                        color: CustomColors().redicon,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Divider(),
          new ListTile(
            title: new Text('News Details'),
            subtitle: new Text(widget.news_detail_text),
          ),
          Divider(),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('News Title', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.news_detail_name, style: TextStyle(color: CustomColors().secondaryColor),), )

            ],
          ),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('News Category', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.news_detail_category, style: TextStyle(color:CustomColors().secondaryColor),), )
            ],
          ),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('News Date', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.news_detail_date, style: TextStyle(color:CustomColors().secondaryColor),), )
            ],
          ),
        ],
      ),
    );
  }
}
