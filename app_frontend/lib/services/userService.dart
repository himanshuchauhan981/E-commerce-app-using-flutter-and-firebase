import 'dart:convert';
import 'package:http/http.dart';

class UserService{
  String url;

  static const Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };

  UserService(){
    url = 'http://127.0.0.1:8000';
  }

  Future<Response> login(userValues) async{
    var uri = Uri.parse("$url/login");
    Response response = await post(uri,headers:headers,body:json.encode(userValues));
    return response;
  }

  Future<Response> signup(userValues) async{
    var uri = Uri.parse("$url/signup");
    Response response = await post(uri,headers: headers, body: json.encode(userValues));
    return response;
  }
}

