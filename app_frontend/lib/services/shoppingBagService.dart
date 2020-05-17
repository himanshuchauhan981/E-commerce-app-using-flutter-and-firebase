import 'package:app_frontend/services/userService.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingBagService{
  UserService userService = new UserService();
  Firestore firestore = Firestore.instance;

  Future<String> updateBagItems(String productId, String size, String color, int quantity, QuerySnapshot data) async{
    String documentId;
    String msg;
    List productItems = data.documents.map((doc){
      documentId = doc.documentID;
      return doc['products'][0];
    }).toList();
    List product = productItems.where((test)=> test['id'] == productId).toList();

    if(product.length != 0){
      productItems.forEach((items){
        if(items['id'] == productId){
          items['size'] = size;
          items['color'] = color;
          items['quantity'] = quantity;
        }
      });
      msg =  "Product added to shopping bag";
    }
    else{
      productItems.add({'id':productId,'size':size,'color':color,'quantity':quantity});
      msg = 'Product updated in shopping bag';
    }
    await firestore.collection('bags').document(documentId).setData({'products':productItems},merge: true);
    return msg;
  }

  Future<String> addToShoppingBag(String productId,String size,String color,int quantity) async{
    String uid = await userService.getUserId();
    String msg;
    QuerySnapshot data = await firestore.collection('bags').where("userId", isEqualTo: uid).getDocuments();

    if(data.documents.length == 0){
      await firestore.collection('bags').add({
        'userId': uid,
        'products':[{
          'id': productId,
          'size': size,
          'color': color,
          'quantity': quantity
        }]
      });
      msg =  "Product added to shopping bag";
    }
    else{
      msg = await updateBagItems(productId, size, color, quantity, data);
    }
    return msg;
  }

  Future<List> listBagItems() async{
    List bagItemsList = new List();
    String uid = await userService.getUserId();

    QuerySnapshot docRef = await firestore.collection('bags').where("userId",isEqualTo: uid).getDocuments();
    List itemDetails = docRef.documents.map((doc){
      return doc.data['products'];
    }).toList()[0];
    var productIdList = itemDetails.map((value) => value['id']).toList();

    for(int i=0;i< productIdList.length;i++){
      Map mapProduct = new Map();
      DocumentSnapshot productRef = await firestore.collection('products').document(productIdList[i]).get();
      mapProduct['id'] = productRef.documentID;
      mapProduct['name'] = productRef.data['name'];
      mapProduct['image'] = productRef.data['image'].cast<String>().toList();
      mapProduct['price']  = productRef.data['price'].toString();
      mapProduct['color'] = productRef.data['color'].cast<String>().toList();
      mapProduct['size'] = productRef.data['size'].cast<String>().toList();
      mapProduct['selectedSize'] = itemDetails[i]['size'];
      mapProduct['selectedColor'] = itemDetails[i]['color'];
      mapProduct['quantity'] = itemDetails[i]['quantity'];
      bagItemsList.add(mapProduct);
    }
     return bagItemsList;
  }

}