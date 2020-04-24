import 'package:flutter/material.dart';

import 'package:app_frontend/pages/signup.dart';
import 'package:app_frontend/pages/login.dart';
import 'package:app_frontend/pages/start.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:app_frontend/components/shop.dart';
import 'package:app_frontend/pages/items.dart';
import 'package:app_frontend/pages/subCategory.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Start(),
    '/login': (context) => Login(),
    '/signup': (context) => Signup(),
    '/home': (context) => Home(),
    '/shop': (context) => Shop(),
    '/subCategory': (context) => SubCategory(),
    '/items': (context) => Items()
  },
));
