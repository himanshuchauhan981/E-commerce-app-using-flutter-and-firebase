import 'dart:math';
import 'package:app_frontend/services/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService{
  Firestore _firestore = Firestore.instance;
  UserService _userService = new UserService();
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

  Future <void> addItemToWishlist(String productId) async{
    String uid = await _userService.getUserId();
    List<dynamic> wishlist = new List<dynamic>();
    QuerySnapshot userRef = await _firestore.collection('users').where('userId',isEqualTo: uid).getDocuments();
    Map userData = userRef.documents[0].data;
    String documentId = userRef.documents[0].documentID;
    if(userData.containsKey('wishlist')){
      wishlist = userData['wishlist'];
      if(wishlist.indexOf(productId) == -1){
        wishlist.add(productId);
      }
    }
    else{
      wishlist.add(productId);
    }
    await _firestore.collection('users').document(documentId).updateData({
      'wishlist': wishlist
    });
  }
}

class NewArrival{
  final String name;
  final String image;

  NewArrival({this.name, this.image});
}