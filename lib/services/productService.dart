import 'dart:math';
import 'package:app_frontend/services/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService{
  Firestore _firestore = Firestore.instance;
  CollectionReference _productReference = Firestore.instance.collection('products');
  CollectionReference _categoryReference = Firestore.instance.collection('category');
  UserService _userService = new UserService();
  List subCategoryList = List();

  Future<Map> listSubCategories(String category) async {
    QuerySnapshot categoryRef = await _categoryReference.where('categoryName',isEqualTo: category).getDocuments();
    Map<String,String> subCategory = new Map();
    for(Map ref in categoryRef.documents[0].data['subCategory']){
      subCategory[ref['subCategoryName']] = ref['image'];
    }
    return subCategory;
  }

  Stream<QuerySnapshot> newItemArrivals(){
    Random rdn = new Random();
    int randomNumber = 1 + rdn.nextInt(20);
    return _firestore.collection('products').orderBy('name').startAt([randomNumber]).limit(5).snapshots();
  }
  
  Stream <QuerySnapshot> featuredItems(){
    return _firestore.collection("products").limit(15).snapshots();
  }
  
  Future <List> listSubCategoryItems(String subCategory) async{

    List<Map<String,String>> itemsList = new List();
    QuerySnapshot productRef = await _productReference.where("subCategory",isEqualTo: subCategory).getDocuments();
    for(DocumentSnapshot docRef in productRef.documents){
      Map<String,String> items  = new Map();
      items['image'] = docRef.data['image'][0];
      items['name'] = docRef.data['name'];
      items['price'] = docRef.data['price'].toString();
      itemsList.add(items);
    }
    return itemsList;
  }
  
  Future <List> listCategories() async{
    QuerySnapshot _categoryRef = await _categoryReference.getDocuments();
    List <Map<String,String>> categoryList = new List();
    for(DocumentSnapshot dataRef in _categoryRef.documents){
      Map<String,String> category = new Map();
      category['categoryName'] = dataRef.data['categoryName'];
      category['categoryImage'] = dataRef.data['categoryImage'];
      categoryList.add(category);
    }
    return categoryList;
  }

  // ignore: missing_return
  Future <String> addItemToWishlist(String productId) async{
    String msg;
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
      else{
        msg = 'Product existed in Wishlist';
        return msg;
      }
    }
    else{
      wishlist.add(productId);
    }
    await _firestore.collection('users').document(documentId).updateData({
      'wishlist': wishlist
    }).then((value){
      msg = 'Product added to wishlist';
    });
  }
}

class NewArrival{
  final String name;
  final String image;

  NewArrival({this.name, this.image});
}