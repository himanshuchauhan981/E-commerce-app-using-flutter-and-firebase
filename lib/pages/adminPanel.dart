import 'package:app_frontend/services/adminService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  AdminService adminService = new AdminService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create sample data'),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child:  Center(
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
            color: Colors.blueAccent,
            onPressed: (){
              adminService.createSampleData();
            },
            child: Text(
              'Load data',
              style: TextStyle(
                fontFamily: 'NovaSquare',
                color: Colors.white,
                fontSize: 25
              ),
            ),
          ),
        ),
      ),
    );
  }
}
