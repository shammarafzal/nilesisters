import 'package:flutter/material.dart';
import 'package:nilesisters/Model/getComments.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Settings/SizeConfig.dart';
import 'package:nilesisters/screens/BottomNavBar/Post/viewFullMessage.dart';
import 'package:nilesisters/utils/Utils.dart';
class ShowComments extends StatefulWidget {
  final int postID;
  const ShowComments({
    super.key,
    required this.postID,
  });
  @override
  _ShowCommentsState createState() => _ShowCommentsState();
}

class _ShowCommentsState extends State<ShowComments> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niesisters'),
      ),
      body: FutureBuilder<GetComments>(
        future: Utils().fetchcomments(widget.postID.toString()),
        builder: (context,snapshot){
          if(snapshot.hasData){
            final comments = snapshot.data!;
            return ListView.builder(itemCount: comments.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index ){
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ViewFullMessage(user_name: comments.data[index].user.name, post_date: comments.data[index].createdAt.toString(), post_text: comments.data[index].comment,),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('from'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Text(comments.data[index].user.name,style: TextStyle(fontSize: 20),),
                          ),
                          ListTile(
                            title: Text(DemoLocalization.of(context)
                                .getTranslatedValue('message'),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                            trailing: Container(
                              width: SizeConfig.screenWidth * 0.5,
                              child: Text(
                                comments.data[index].comment,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                // softWrap: false,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child:  Text('No Comments'),);
        },
      ),
    );
  }

}
