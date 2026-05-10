import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getHome.dart';
import 'package:nilesisters/Settings/customColors.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/screens/BottomNavBar/News/newsDetails.dart';
import 'package:nilesisters/utils/Utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<GetHome>(
          future: Utils().fetchhome(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final news = snapshot.data!;
              return ListView.builder(
                itemCount: news.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    height: 300.0,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new NewsDetails(
                                news_detail_name: news.data[index].title,
                                news_detail_link: news.data[index].newsLink,
                                news_detail_text: news.data[index].description,
                                news_detail_category: news.data[index].category,
                                news_detail_image: Utils().image_base_url +
                                    '${news.data[index].image}',
                                news_detail_date:
                                    '${news.data[index].createdAt.month}/${news.data[index].createdAt.day}/${news.data[index].createdAt.year}',
                              ),
                            ),
                          );
                        },
                        child: GridTile(
                            child: Container(
                              color: CustomColors().buttonTextColor,
                              child: Image.network(Utils().image_base_url +
                                '${news.data[index].image}'),
                          ),
                          footer: new Container(
                            color: Colors.white70,
                            child: ListTile(
                              leading:
                              SizedBox(width: SizeConfig.screenWidth*0.8, child: Text(news.data[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),)
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(216, 56, 48, 1)),
              ),
            );
          },
        ),
      ),
    );
  }
}
