import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';

class AdminService {
  FirebaseFirestore _firestore;
  CollectionReference _categoryReference;
  CollectionReference _subCategoryReference;
  CollectionReference _productsReference;

  initiateFirebase() async{
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _categoryReference = FirebaseFirestore.instance.collection('category');
    _subCategoryReference = FirebaseFirestore.instance.collection('subCategory');
    _productsReference = FirebaseFirestore.instance.collection('products');
  }

  AdminService(){
    initiateFirebase();
  }

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  List setSizeList(product){
    List sizeList = new List();
    String size1 = product[12].toString();
    String size2 = product[13].toString();
    String size3 = product[14].toString();
    String size4 = product[15].toString();
    String size5 = product[16].toString();
    String size6 = product[17].toString();
    String size7 = product[18].toString();

    if(size1 != '-'){
      sizeList.add(size1);
      if(size2 != '-'){
        sizeList.add(size2);
        if(size3 != '-'){
          sizeList.add(size3);
          if(size4 != '-'){
            sizeList.add(size4);
            if(size5 != '-'){
              sizeList.add(size6);
              if(size6 != '-'){
                sizeList.add(size6);
                if(size7 != '-'){
                  sizeList.add(size7);
                }
              }
            }
          }
        }
      }
    }
    return sizeList;
  }

  List setColorList(product){
    List colorList = new List();
    String color1 = product[8].toString();
    String color2 = product[9].toString();
    String color3 = product[10].toString();
    String color4 = product[11].toString();
    
    if(color1 != '-'){
      colorList.add('0xFF$color1');
      if(color2 != '-'){
        colorList.add('0xFF$color2');
        if(color3 != '-'){
          colorList.add('0xFF$color3');
          if(color4 != '-'){
            colorList.add('0xFF$color4');
          }
        }
      }
    }
    return colorList;
  }

  void createSampleData() {
    Map tempCategoryData = new Map<String, dynamic>();
    loadAsset('assets/csv/CATEGORY_MOCK_DATA.csv').then((dynamic value) async {
      List<List<dynamic>> categories = const CsvToListConverter().convert(value);
      int i;
      for (i = 1; i < categories.length; i++) {
        String key = categories[i][1];
        var value = categories.where((test) => test[1] == key).toList();
        tempCategoryData[key] = value;
      }

      for(String key in tempCategoryData.keys){
        _firestore.collection('category').add({
          'name':key,
          'image': tempCategoryData[key][0][3],
        }).then((response) async{
          String categoryId = response.id;
          for(int i=0;i<tempCategoryData[key].length;i++){
            await _firestore.collection('subCategory').add({
              'categoryId': categoryId,
              'name': tempCategoryData[key][i][2],
              'imageId':tempCategoryData[key][i][0],
            });
          }
        });
      }

      loadAsset('assets/csv/PRODUCTS_MOCK_DATA.csv').then((dynamic value) async{
        List<List<dynamic>> tempProductData = const CsvToListConverter().convert(value);

        QuerySnapshot subCategorySnapshot;

        for(int i=1;i<tempProductData.length;i++){
          String categoryName = tempProductData[i][2];
          String subCategoryName = tempProductData[i][3];

          List colorList = setColorList(tempProductData[i]);
          List sizeList = setSizeList(tempProductData[i]);
          int maxQuantity = tempProductData[i][7];

          QuerySnapshot categorySnapshot = await _categoryReference.where('name',isEqualTo: categoryName).get();
          String categoryId = categorySnapshot.docs[0].id;
          subCategorySnapshot = await _subCategoryReference.where('name',isEqualTo: subCategoryName).get();

          String subCategoryId = subCategorySnapshot.docs[0].id;

          List<String> image = new List<String>();
          for(int j =0;j<3;j++){
            image.add(tempProductData[i][0]);
          }

          _productsReference.add({
            'name':tempProductData[i][1],
            'category': categoryId,
            'subCategory':subCategoryId,
            'availableQuantity':tempProductData[i][4],
            'orderedQuantity': tempProductData[i][5],
            'price': tempProductData[i][6],
            'imageId':image,
            'orderLimit':maxQuantity,
            'size':sizeList,
            'color':colorList
          });
        }
      });
    });
  }
}
