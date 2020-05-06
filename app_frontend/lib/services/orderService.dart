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

  Future<void> addToShoppingBag(String productId) async{

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
      }
    }
    else{
      await firestore.collection('bags').add({
        'quantity': 1,
        'userId': uid,
        'productId': [productId]
      });
    }

  }
}