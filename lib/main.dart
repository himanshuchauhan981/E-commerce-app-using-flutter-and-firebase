import 'package:flutter/material.dart';

import 'package:app_frontend/pages/signup.dart';
import 'package:app_frontend/pages/login.dart';
import 'package:app_frontend/pages/start.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:app_frontend/components/shop.dart';
import 'package:app_frontend/pages/products/items.dart';
import 'package:app_frontend/pages/products/subCategory.dart';
import 'package:app_frontend/pages/shoppingBag.dart';
import 'package:app_frontend/pages/checkout/addCreditCard.dart';
import 'package:app_frontend/pages/checkout/paymentMethod.dart';
import 'package:app_frontend/pages/checkout/shippingAddress.dart';
import 'package:app_frontend/pages/checkout/shippingMethod.dart';
import 'package:app_frontend/pages/products/particularItem.dart';
import 'package:app_frontend/pages/checkout/placeOrder.dart';
import 'package:app_frontend/pages/profile/userProfile.dart';
import 'package:app_frontend/pages/profile/editProfile.dart';
import 'package:app_frontend/pages/profile/setting.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/profile/edit',
  routes: {
    '/': (context) => Start(),
    '/login': (context) => Login(),
    '/signup': (context) => Signup(),
    '/home': (context) => Home(),
    '/shop': (context) => Shop(),
    '/subCategory': (context) => SubCategory(),
    '/items': (context) => Items(),
    '/particularItem': (context) => ParticularItem(),
    '/bag': (context) => ShoppingBag(),
    '/addCreditCard': (context) => AddCreditCard(),
    '/address': (context) => ShippingAddress(),
    '/shippingMethod': (context) => ShippingMethod(),
    '/paymentMethod': (context) => PaymentMethod(),
    '/placeOrder': (context) => PlaceOrder(),
    '/profile': (context) => UserProfile(),
    '/profile/settings': (context) => ProfileSetting(),
    '/profile/edit': (context) => EditProfile()
  },

));
