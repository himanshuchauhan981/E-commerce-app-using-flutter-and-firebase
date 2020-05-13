import 'package:app_frontend/services/userService.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService{
  UserService userService = new UserService();
  Firestore firestore = Firestore.instance;

  Future<String> updateBagItems(String productId, String size, String color, QuerySnapshot data) async{
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
        }
      });
      msg =  "Product added to shopping bag";
    }
    else{
      productItems.add({'id':productId,'size':size,'color':color,'quantity':1});
      msg = 'Product updated in shopping bag';
    }
    await firestore.collection('bags').document(documentId).setData({'products':productItems},merge: true);
    return msg;
  }

  Future<String> addToShoppingBag(String productId,String size,String color) async{
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
          'quantity': 1
        }]
      });
      msg =  "Product added to shopping bag";
    }
    else{
      msg = await updateBagItems(productId, size, color, data);
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
      Map <String,dynamic> mapProduct = new Map<String,dynamic>();
      DocumentSnapshot productRef = await firestore.collection('products').document(productIdList[i]).get();
      mapProduct['name'] = productRef.data['name'];
      mapProduct['image'] = productRef.data['image'][0];
      mapProduct['price']  = productRef.data['price'];
      mapProduct['size'] = productRef.data['size'];
      mapProduct['color'] = productRef.data['color'];
      mapProduct['selectedSize'] = itemDetails[i]['size'];
      mapProduct['selectedColor'] = itemDetails[i]['color'];
      bagItemsList.add(mapProduct);
    }
    return bagItemsList;
  }

}