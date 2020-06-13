import 'package:app_frontend/components/header.dart';
import 'package:flutter/material.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Settings', _scaffoldKey, showCartIcon, context),
      body: Container(
        padding: EdgeInsets.only(top: 40.0,left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SECURITY',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.0
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'Enable Face ID / Touch ID login',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value){},
                activeColor: Colors.green,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'PUSH NOTIFICATIONS',
              style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.0
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'Order Updates',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value){},
                activeColor: Colors.green,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'New arrivals',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value){},
                activeColor: Colors.green,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'Promotions',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value){},
                activeColor: Colors.green,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'Sales alerts',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value){},
                activeColor: Colors.green,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'ACCOUNT',
              style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.0
              ),
            ),
            SizedBox(height: 10.0),
            Material(
              color: Colors.white,
              child: ListTile(
                title: Center(
                  child: Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: ListTile(
                title: Center(
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
