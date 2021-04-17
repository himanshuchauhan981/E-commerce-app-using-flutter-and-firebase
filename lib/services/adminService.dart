import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class AdminService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _categoryReference = FirebaseFirestore.instance.collection('category');
  CollectionReference _subCategoryReference = FirebaseFirestore.instance.collection('subCategory');
  CollectionReference _productsReference = FirebaseFirestore.instance.collection('products');

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
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
            'size':['S','M','L','XL','2XL'],
            'color':['0xFF0000ff','0xFF000000','0xFF8b4513']
          });
        }
      });
    });
  }
}
