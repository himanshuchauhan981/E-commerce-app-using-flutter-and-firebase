import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliver_glue/sliver_glue.dart';

class ShowBottomScreen extends StatelessWidget {
  final List iconList = new List();
  void createIconList(){
    iconList.add({'name':'Message', 'iconName':FontAwesomeIcons.envelope, 'color':Color(0xff4168e1)});
    iconList.add({'name':'News Feed', 'iconName':FontAwesomeIcons.facebook, 'color':Color(0xff3b5998)});
    iconList.add({'name':'Direct', 'iconName':FontAwesomeIcons.instagram, 'color':Color(0xffddd287b)});
    iconList.add({'name':'WhatsApp', 'iconName':FontAwesomeIcons.whatsapp, 'color':Color(0xff128C7E)});
    iconList.add({'name':'Save to drive', 'iconName':FontAwesomeIcons.googleDrive,'color':Color(0xffFFD04B)});
    iconList.add({'name':'Private message', 'iconName':FontAwesomeIcons.linkedin, 'color':Color(0xff0e76a8)});
    iconList.add({'name':'Telegram', 'iconName':FontAwesomeIcons.telegram, 'color':Color(0xff0088cc)});
  }

  @override
  Widget build(BuildContext context) {
    createIconList();
    return Container(
      color: Color(0xFF737373),
      height: 370,
      child: Container(
//        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
            )
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 26.0,
                crossAxisCount: 4
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Column(
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(iconList[index]['iconName']),
                      color: iconList[index]['color'],
                      iconSize: 55.0,
                      onPressed: (){},
                    ),
                    Text(iconList[index]['name'])
                  ],
                );
              },
                childCount: iconList.length
              )
            ),
            SliverGlueFixedList(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              widgets: <Widget>[
                Divider(color: Colors.grey),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 80.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: IconButton(
                              icon: Icon(Icons.list),
                              iconSize: 55.0,
                              onPressed: (){},
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                              'Add to reading list',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: IconButton(
                              icon: Icon(Icons.insert_drive_file),
                              iconSize: 55.0,
                              onPressed: (){},
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Copy',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: IconButton(
                              icon: Icon(Icons.more_horiz),
                              iconSize: 55.0,
                              onPressed: (){},
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'More',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
