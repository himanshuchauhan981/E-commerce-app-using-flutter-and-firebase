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
  
  Future <Response> newItemArrivals() async{
    var uri = Uri.parse("$url/items/new");
    Response response = await get(uri, headers: headers);
    return response;
  }
}

class NewArrival{
  final String name;
  final String image;

  NewArrival({this.name, this.image});
}