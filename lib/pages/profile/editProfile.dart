import 'package:app_frontend/components/header.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;
  String firstName, lastName, mobileNumber, email;

  setProfileDetails(){
    dynamic args = ModalRoute.of(context).settings.arguments;
    setState(() {
      firstName = args['firstName'];
      lastName = args['lastName'];
      mobileNumber = args['mobileNumber'];
      email = args['email'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    setProfileDetails();
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
                firstName,
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
                lastName,
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
                email,
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
                mobileNumber,
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
