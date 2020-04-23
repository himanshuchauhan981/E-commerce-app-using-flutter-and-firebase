import 'package:app_frontend/pages/subCategory.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/pages/signup.dart';
import 'package:app_frontend/pages/login.dart';
import 'package:app_frontend/pages/start.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:app_frontend/components/shop.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/signup',
  routes: {
    '/': (context) => Start(),
    '/login': (context) => Login(),
    '/signup': (context) => Signup(),
    '/home': (context) => Home(),
    '/shop': (context) => Shop(),
    '/subCategory': (context) => SubCategory()
  },
));
