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
              return ListView.builder(
                itemCount: snapshot.data.data.length,
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
                                news_detail_name:
                                    snapshot.data.data[index].title,
                                news_detail_text:
                                    snapshot.data.data[index].description,
                                news_detail_category:
                                    snapshot.data.data[index].category,
                                news_detail_image: Utils().image_base_url +
                                    '${snapshot.data.data[index].image}',
                                news_detail_date:
                                    '${snapshot.data.data[index].createdAt.month}/${snapshot.data.data[index].createdAt.day}/${snapshot.data.data[index].createdAt.year}',
                              ),
                            ),
                          );
                        },
                        child: GridTile(
                          child: Container(
                            color: CustomColors().buttonTextColor,
                            child: Image.network(Utils().image_base_url +
                                '${snapshot.data.data[index].image}'),
                          ),
                          footer: new Container(
                            color: Colors.white70,
                            child: ListTile(
                              leading: new Text(snapshot.data.data[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                              // trailing: Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(5),
                              //     color: Colors.grey
                              //   ),
                              //   //color: Colors.grey,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(2.0),
                              //     child: new Text(
                              //       snapshot.data.data[index].category,
                              //       style: TextStyle(
                              //         color: CustomColors().redicon,
                              //         fontSize: 20,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),
                              // ),

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
