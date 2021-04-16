import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:corsac_jwt/corsac_jwt.dart';

class UserService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();
  final String sharedKey = 'sharedKey';
  int statusCode;
  String msg;

  void createAndStoreJWTToken(String uid) async{
    var builder = new JWTBuilder();
    var token = builder
    ..expiresAt = new DateTime.now().add(new Duration(hours: 3))
    ..setClaim('data', {'uid': uid})
    ..getToken();

    var signer = new JWTHmacSha256Signer(sharedKey);
    var signedToken = builder.getSignedToken(signer);
    await storage.write(key: 'token', value: signedToken.toString());
  }

  String validateToken(String token){
    var signer = new JWTHmacSha256Signer(sharedKey);
    var decodedToken = new JWT.parse(token);
    if(decodedToken.verify(signer)){
      final parts = token.split('.');
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      final int expiry = jsonDecode(decoded)['exp']* 1000;
      final currentDate = DateTime.now().millisecondsSinceEpoch;
      if(currentDate > expiry){
        return null;
      }
      return  jsonDecode(decoded)['data']['uid'];
    }
    return null;
  }

  void logOut(context) async{
    await storage.delete(key: 'token');
    Navigator.of(context).pushReplacementNamed('/');
  }

  Future<void> login(userValues) async{
    String email = userValues['email'];
    String password = userValues['password'];

    await _auth.signInWithEmailAndPassword(email: email, password: password).then((dynamic user) async{
      final User currentUser = _auth.currentUser;
      final uid = currentUser.uid;

      createAndStoreJWTToken(uid);

      statusCode = 200;

    }).catchError((error){
      handleAuthErrors(error);
    });
  }

  Future<String> getUserId() async{
    var token = await storage.read(key: 'token');
    var uid = validateToken(token);
    return uid;
  }

  Future<void> signup(userValues) async{
    String email = userValues['email'];
    String password = userValues['password'];

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((dynamic user){
      String uid = user.user.uid;
      _firestore.collection('users').add({
        'fullName': userValues['fullName'],
        'mobileNumber': userValues['mobileNumber'],
        'userId': uid
      });

      statusCode = 200;
    }).catchError((error){
      handleAuthErrors(error);
    });
  }

  void handleAuthErrors(error){
    String errorCode = error.code;
    switch(errorCode){
      case "ERROR_EMAIL_ALREADY_IN_USE":
        {
          statusCode = 400;
          msg = "Email ID already existed";
        }
        break;
      case "ERROR_WRONG_PASSWORD":
        {
          statusCode = 400;
          msg = "Password is wrong";
        }
    }
  }

  String capitalizeName(String name){
    name = name[0].toUpperCase()+ name.substring(1);
    return name;
  }

  String userEmail(){
    var user = _auth.currentUser;
    return user.email;
  }

  Future<List> userWishlist() async{
    String uid = await getUserId();
    QuerySnapshot userRef = await _firestore.collection('users').where('userId',isEqualTo: uid).get();

    Map userData = userRef.docs[0].data();
    List userWishList = new List();

    if(userData.containsKey('wishlist')){
      for(String item in userData['wishlist']){
        Map<String, dynamic> tempWishList = new Map();
        DocumentSnapshot productRef = await _firestore.collection('products').doc(item).get();
        tempWishList['productName'] = productRef.data()['name'];
        tempWishList['price'] = productRef.data()['price'];
        tempWishList['image'] = productRef.data()['image'];
        tempWishList['productId'] = productRef.id;
        userWishList.add(tempWishList);
      }
    }
    return userWishList;
  }

  Future<void> deleteUserWishlistItems(String productId) async{
    String uid = await getUserId();
    QuerySnapshot userRef = await _firestore.collection('users').where('userId',isEqualTo: uid).get();
    String documentId = userRef.docs[0].id;
    Map<String,dynamic> wishlist = userRef.docs[0].data();
    wishlist['wishlist'].remove(productId);

    await _firestore.collection('users').doc(documentId).update({
      'wishlist':wishlist['wishlist']
    });
  }
}

