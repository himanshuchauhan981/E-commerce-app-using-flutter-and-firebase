import 'package:flutter/material.dart';

import 'package:app_frontend/pages/signup.dart';
import 'package:app_frontend/pages/login.dart';
import 'package:app_frontend/pages/start.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/signup',
  routes: {
    '/': (context) => Start(),
    '/login': (context) => Login(),
    '/signup': (context) => Signup()
  },
));
