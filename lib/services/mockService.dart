import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class GenerateMock{
  Firestore _firestore = Firestore.instance;

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<void> saveProductMockData(String name,String category,String subCategory,int available,int ordered,int price, var image) async{
    await _firestore.collection('products').add({
      'name': name,
      'category': category,
      'subCategory': subCategory,
      'availableQuantity': available,
      'orderedQuantity': ordered,
      'price': price,
      'image': image
    }).then((value){
      print('Addeed successfully');
    });
  }

  Future<void> saveCategoryMockData(String key, dynamic value) async{
    await _firestore.collection('category').add({
      'categoryName':key,
      'subCategory': value
    });
  }

  void generateProductMockData() async{
   loadAsset('assets/csv/PRODUCT_MOCK_DATA.csv').then((dynamic output) async{
     List<List<dynamic>> productsdata = const CsvToListConverter().convert(output);
     int i;
     for(i=1;i<productsdata.length;i++){
       String category = productsdata[i][1];
       if(category != 'clothing'){
         String name = productsdata[i][0];
         String subCategory = productsdata[i][2];
         var available = productsdata[i][3];
         var ordered = productsdata[i][4];
         var price = productsdata[i][5];
         String image = productsdata[i][6];
         var imageList = [image,image,image];
         await saveProductMockData(name, category, subCategory, available, ordered, price, imageList);
       }
     }
   });
  }

  void updateProductMockData() async {
    List<String> size = [];
    List<String> color = ['0xFF0000ff','0xFF000000','0xFF8b4513'];
    QuerySnapshot docRef = await _firestore.collection('products').where('subCategory',isEqualTo: 'wallets').getDocuments();
    for(int i=0;i<docRef.documents.length;i++){
      String documentId = docRef.documents[i].documentID;

      await _firestore.collection('products').document(documentId).setData({
        'size': size,
        'color':color
      },merge: true);
    }
  }

  void generateCategoryMockData() async{
    HashMap hashMap = new HashMap<String,dynamic>();
    loadAsset('assets/csv/CATEGORY_MOCK_DATA.csv').then((dynamic output) async{
      List<List<dynamic>> categorydata = const CsvToListConverter().convert(output);
      int i;
      for(i=1;i<categorydata.length;i++){
        String key = categorydata[i][0];
        var value = categorydata.where((test) => test[0] == key).toList();
        hashMap[key] = value;
      }

      for(String key in hashMap.keys){
        List <dynamic> subCategory = List<dynamic>();
        for(var j in hashMap[key]){
          subCategory.add({
            'subCategoryName': j[1],
            'image': j[2]
          });
        }
        await saveCategoryMockData(key, subCategory);
      }
    });
  }
}