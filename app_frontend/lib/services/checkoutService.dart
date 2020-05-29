import 'package:app_frontend/services/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutService {
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  Firestore _firestore = Firestore.instance;
  UserService _userService = new UserService();

  void shippingAddress() async{
    String uid = await _userService.getUserId();
//    print(uid);
  }
}