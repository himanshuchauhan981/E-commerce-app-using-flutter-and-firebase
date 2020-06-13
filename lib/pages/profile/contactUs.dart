import 'package:app_frontend/components/header.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Contact Us', _scaffoldKey, showCartIcon, context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'CONTACT US',
                style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Our address'
              ),
              subtitle: Text(
                '1412 Steiner Street, San Francisco, CA, 94115'
              ),
            ),
            ListTile(
              leading: Text(
                'E-mail us'
              ),
              trailing: Text(
                'office@shopertino.com'
              ),
            ),
            Text(
              'Our business hour are Mon - Fri, 10am - 6pm, PST'
            ),
            SizedBox(height: 20.0),
            ListTile(
              title: Center(
                child: Text(
                  'Call Us'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
