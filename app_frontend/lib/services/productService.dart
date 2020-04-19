import 'package:http/http.dart';

class ProductService{
  String url;

  ProductService(){
    url = 'http://127.0.0.1:8000';
  }

  static const Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };

  Future <Response> subCategories(String item) async{
    var uri = Uri.parse("$url/$item/sub");
    Response response = await get(uri,headers: headers);
    return response;
  }
}