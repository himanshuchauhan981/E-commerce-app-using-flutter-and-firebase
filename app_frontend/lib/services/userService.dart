import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class UserService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  final storage = new FlutterSecureStorage();
  final String sharedKey = 'sharedKey';
  int statusCode;
  String msg;

  void createAndStoreJWTToken(String uid) async{
    final claimSet = new JwtClaim(
        maxAge: Duration(minutes: 3),
        otherClaims: <String, String>{
          'uid': uid
        }
    );

    final token = issueJwtHS256(claimSet, sharedKey);
    await storage.write(key: 'token', value: token);
  }

  String validateToken(String token){
    try{
      final decClaimSet = verifyJwtHS256Signature(token, sharedKey);

      final parts = token.split('.');
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);

      return jsonDecode(decoded)['uid'];
    }
    catch(e){
      return null;
    }
  }

  void logOut(context) async{
    await storage.delete(key: 'token');
    Navigator.of(context).pushReplacementNamed('/');
  }

  Future<void> login(userValues) async{
    String email = userValues['email'];
    String password = userValues['password'];

    await _auth.signInWithEmailAndPassword(email: email, password: password).then((dynamic user) async{
      final FirebaseUser currentUser = await _auth.currentUser();
      final uid = currentUser.uid;

      createAndStoreJWTToken(uid);

      statusCode = 200;

    }).catchError((error){
      handleAuthErrors(error);
    });
  }

  Future<void> signup(userValues) async{
    String email = userValues['email'];
    String password = userValues['password'];

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((dynamic user){
      String uid = user.user.uid;
      firestore.collection('users').add({
        'firstName': capitalizeName(userValues['firstName']),
        'lastName': capitalizeName(userValues['lastName']),
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
}

