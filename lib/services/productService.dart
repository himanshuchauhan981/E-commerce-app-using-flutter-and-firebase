import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService{
  Firestore _firestore = Firestore.instance;
  List subCategoryList = List();

  Stream<QuerySnapshot> listSubCategories(String item) {
    return _firestore.collection('category').where("categoryName", isEqualTo: item).snapshots();
  }

  Stream<QuerySnapshot> newItemArrivals(){
    Random rdn = new Random();
    int randomNumber = 1 + rdn.nextInt(20);
    return _firestore.collection('products').orderBy('name').startAt([randomNumber]).limit(5).snapshots();
  }
  
  Stream <QuerySnapshot> featuredItems(){
    return _firestore.collection("products").limit(15).snapshots();
  }
  
  Stream <QuerySnapshot> listSubCategoryItems(String subCategory){
    return _firestore.collection("products").where("subCategory",isEqualTo: subCategory).snapshots();
  }
  
  Stream <QuerySnapshot> listAllCategories(){
    return _firestore.collection("category").snapshots();
  }
}

class NewArrival{
  final String name;
  final String image;

  NewArrival({this.name, this.image});
}