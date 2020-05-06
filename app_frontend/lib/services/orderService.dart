import 'package:app_frontend/services/userService.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService{
  UserService userService = new UserService();
  Firestore firestore = Firestore.instance;

  Future<bool> checkItemsInBags(String productId) async{
    var data = await firestore.collection('bags').where("productId", arrayContains: productId).getDocuments();
    if(data.documents.length != 0){
      return true;
    }
    else{
      return false;
    }
  }

  Future<String> addToShoppingBag(String productId) async{
    String uid = await userService.getUserId();
    QuerySnapshot data = await firestore.collection('bags').where("userId", isEqualTo: uid).getDocuments();

    if(data.documents.length != 0){
      bool status = await checkItemsInBags(productId);
      if(!status){
        data.documents.forEach((DocumentSnapshot docs)async{
          List<dynamic> productIdList;
          String documentID = docs.documentID;
          productIdList = docs.data['productId'];
          productIdList.add(productId);
          await firestore.collection('bags').document(documentID).updateData({
            "productId":productIdList
          });
        });
        return "Product added to shopping bag";
      }
      return "Product already existed in shopping bag";
    }
    else{
      await firestore.collection('bags').add({
        'quantity': 1,
        'userId': uid,
        'productId': [productId]
      });
      return "Product added to shopping bag";
    }
  }

  Future<List> listBagItems() async{
    List bagItemsList = new List();
    String uid = await userService.getUserId();
    QuerySnapshot docRef = await firestore.collection('bags').where("userId",isEqualTo: uid).getDocuments();
    var itemDetails = docRef.documents.map((doc){
      Map<String,dynamic> mapProductId = new Map<String,dynamic>();
      mapProductId['productId'] = doc.data['productId'];
      mapProductId['quantity'] = doc.data['quantity'];
      return mapProductId;
    }).toList()[0];
    List productIdList = itemDetails['productId'];

    for(int i=0;i< productIdList.length;i++){
      Map <String,dynamic> mapProduct = new Map<String,dynamic>();
      DocumentSnapshot productRef = await firestore.collection('products').document(productIdList[i]).get();
      mapProduct['name'] = productRef.data['name'];
      mapProduct['image'] = productRef.data['image'][0];
      mapProduct['price']  = productRef.data['price'];
      bagItemsList.add(mapProduct);
    }
    return bagItemsList;
  }

}