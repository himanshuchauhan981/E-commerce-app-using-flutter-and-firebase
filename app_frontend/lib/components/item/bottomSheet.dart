import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowBottomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: new Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: (){},
                    iconSize: 60.0,
                  ),
                  Text('Message')
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.mail),
                    iconSize: 60.0,
                    onPressed: (){},
                  ),
                  Text('Mail')
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    iconSize: 60.0,
                    onPressed: (){},
                  ),
                  Text('Facebook')
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    iconSize: 60.0,
                    onPressed: (){},
                  ),
                  Text('Instagram')
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.whatsapp),
                    iconSize: 60.0,
                    onPressed: (){},
                  ),
                  Text('Whatsapp')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


