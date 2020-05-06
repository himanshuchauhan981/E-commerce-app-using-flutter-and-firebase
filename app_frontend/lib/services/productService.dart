import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService{
  Firestore firestore = Firestore.instance;
  List subCategoryList = List();

  Stream<QuerySnapshot> listSubCategories(String item) {
    return firestore.collection('category').where("categoryName", isEqualTo: item).snapshots();
  }

  Stream<QuerySnapshot> newItemArrivals(){
    Random rdn = new Random();
    int randomNumber = 1 + rdn.nextInt(20);
    return firestore.collection('products').orderBy('name').startAt([randomNumber]).limit(5).snapshots();
  }
  
  Stream <QuerySnapshot> featuredItems(){
    return firestore.collection("products").limit(15).snapshots();
  }
  
  Stream <QuerySnapshot> listSubCategoryItems(String subCategory){
    return firestore.collection("products").where("subCategory",isEqualTo: subCategory).snapshots();
  }
  
  Stream <QuerySnapshot> listAllCategories(){
    return firestore.collection("category").snapshots();
  }

  void addToShoppingBag(String productId){

  }
}

class NewArrival{
  final String name;
  final String image;

  NewArrival({this.name, this.image});
}