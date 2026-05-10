import 'package:flutter/material.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  final String news_detail_name;
  final String news_detail_category;
  final String news_detail_text;
  final String news_detail_image;
  final String news_detail_date;
  final String news_detail_link;

  const NewsDetails({
    super.key,
    required this.news_detail_name,
    required this.news_detail_category,
    required this.news_detail_text,
    required this.news_detail_image,
    required this.news_detail_date,
    required this.news_detail_link,
  });

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  _launchLink() async {
    final url = widget.news_detail_link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  leading:  SizedBox(width: SizeConfig.screenWidth*0.8, child: Text(widget.news_detail_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0)),)
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
                child:  SizedBox(width: SizeConfig.screenWidth*0.6, child: Text(widget.news_detail_name, style: TextStyle(color: CustomColors().secondaryColor),),) )

            ],
          ),
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('News Category', style: TextStyle(color: CustomColors().grey)),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.news_detail_category, style: TextStyle(color:CustomColors().redicon),), )
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
          Row(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text('News Link', style: TextStyle(color: CustomColors().grey)),),
              InkWell(
                onTap: () async{
                  _launchLink();


                },
                child: Padding(padding: EdgeInsets.all(5.0),
                  child: new Text(widget.news_detail_link, style: TextStyle(color:CustomColors().secondaryColor),), ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
