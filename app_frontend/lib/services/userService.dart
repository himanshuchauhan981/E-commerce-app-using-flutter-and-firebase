import 'dart:convert';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  String url;
  int statusCode;
  String msg;

  static const Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };

  UserService(){
    url = 'http://127.0.0.1:8000';
  }

  Future<void> login(userValues) async{
    String email = userValues['email'];
    String password = userValues['password'];

    await _auth.signInWithEmailAndPassword(email: email, password: password).then((dynamic user){
      statusCode = 200;
    }).catchError((error){
      handleAuthErrors(error);
    });
//    var uri = Uri.parse("$url/login");
//    Response response = await post(uri,headers:headers,body:json.encode(userValues));
//    return response;
  }

  Future<void> signup(userValues) async{
    String email = userValues['email'];
    String password = userValues['password'];

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((dynamic user){
      String uid = user.user.uid;
      _firestore.collection('users').add({
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

