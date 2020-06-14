import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/services/profileService.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/components/header.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ProfileService _profileService = new ProfileService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Profile', _scaffoldKey,showCartIcon,context),
      drawer: sidebar(context),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/userProfile.jpg')
                )
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Sample Name',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0
              ),
            ),
            SizedBox(height: 60.0),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 40.0,
                color: Colors.blueAccent,
              ),
              title: Text(
                'Account Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35.0,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                size: 40.0,
                color: Colors.red,
              ),
              title: Text(
                'WishList',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35.0,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.local_shipping,
                size: 40.0,
              ),
              title: Text(
                'Order History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35.0,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 40.0,
                color: Colors.grey,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35.0,
              ),
              onTap: () async{
                QuerySnapshot userSettings = await _profileService.getUserSettings();
                Navigator.of(context).pushNamed('/profile/settings', arguments: userSettings.documents[0].data);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.phone_in_talk,
                size: 40.0,
                color: Colors.green,
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35.0,
              ),
              onTap: () async{
//                Navigator.of(context).pushNamed('/profile/contactUs');
              },
            ),
            SizedBox(height: 60.0),
            ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                child: FlatButton(
                  onPressed: (){ },
                  color: Colors.white,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black26,
                        width: 2.0
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
