import 'package:app_frontend/components/header.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Edit Profile', _scaffoldKey, showCartIcon, context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'PUBLIC PROFILE',
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 1.0
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: Text(
                'First Name',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              trailing: Text(
                'Your first name',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: Text(
                'Last Name',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Text(
                'Your last name',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'PRIVATE PROFILE',
                style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: Text(
                'E-mail Address',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Text(
                'Your email',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: Text(
                'Phone number',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Text(
                'Your phone number',
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
