import 'package:app_frontend/services/userService.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShoppingBagService{
  UserService userService = new UserService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _shoppingBagReference = FirebaseFirestore.instance.collection('bags');
  CollectionReference _productReference = FirebaseFirestore.instance.collection('products');

  Future<String> update(String productId, String size, String color, int quantity, QuerySnapshot bagItems) async{
    String documentId;
    String msg;
    List productItems = bagItems.docs.map((doc){
      documentId = doc.id;
      return doc['products'];
    }).toList()[0];
    List product = productItems.where((test)=> test['id'] == productId).toList();

    if(product.length != 0){
      productItems.forEach((items){
        if(items['id'] == productId){
          items['size'] = size;
          items['color'] = color;
          items['quantity'] = quantity;
        }
      });
      await _shoppingBagReference.doc(documentId).update({'products':productItems});
      msg =  "Product updated in shopping bag";
    }
    else{
      productItems.add({'id':productId,'size':size,'color':color,'quantity':quantity});
      await _shoppingBagReference.doc(documentId).update({'products':productItems});
      msg = 'Product added to shopping bag';
    }
    return msg;
  }

  Future<String> add(String productId,String size,String color,int quantity) async{
    String uid = await userService.getUserId();
    String msg;
    QuerySnapshot userBag = await _shoppingBagReference.where("userId", isEqualTo: uid).get();
    if(userBag.docs.length == 0){
      await _firestore.collection('bags').add({
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
      msg = await update(productId, size, color, quantity, userBag);
    }
    return msg;
  }

  Future<String> downloadStorageImage(String image) {
    Reference imageRef = FirebaseStorage.instance.ref().child('/$image.jpg');
    return imageRef.getDownloadURL();
  }

  Future<List> list() async{
    List bagItemsList = new List();
    List bagItemDetails ;
    String uid = await userService.getUserId();

    QuerySnapshot userBagDocRef = await _shoppingBagReference.where("userId",isEqualTo: uid).get();

    int totalBags = userBagDocRef.docs.length;

    if(totalBags != 0){
      bagItemDetails = userBagDocRef.docs.map((bagDoc){
        return bagDoc.data()['products'];
      }).toList()[0];

      for(int i=0; i < bagItemDetails.length; i++){
        Map bagItems = new Map();

        DocumentSnapshot productRef = await _productReference.doc(bagItemDetails[i]['id']).get();
        String image = productRef.data()['imageId'][0];

        String imageUrl = (await downloadStorageImage(image)).toString();
        bagItems['productId'] = productRef.id;
        bagItems['name']  = productRef.data()['name'];
        bagItems['image'] = imageUrl;
        bagItems['price']  = productRef.data()['price'].toString();
        bagItems['color'] = productRef.data()['color'].cast<String>().toList();
        bagItems['size'] = productRef.data()['size'].cast<String>().toList();
        bagItems['selectedSize'] = bagItemDetails[i]['size'];
        bagItems['selectedColor'] = bagItemDetails[i]['color'];
        bagItems['quantity'] = bagItemDetails[i]['quantity'];
        bagItemsList.add(bagItems);
      }
    }

    return bagItemsList;
  }

  Future<void> remove(String id) async{
    String uid = await userService.getUserId();

    await _shoppingBagReference.where('userId',isEqualTo: uid).get().then((QuerySnapshot doc){
      doc.docs.forEach((docRef) async{
        List products = docRef['products'];
        if(products.length == 1){
          await _shoppingBagReference.doc(docRef.id).delete();
        }
        else{
          products.removeWhere((productData) => productData['id'] == id);
          await _shoppingBagReference.doc(docRef.id).update({'products':products});
        }
      });
    });
  }

  Future<void> delete() async{
    String uid = await userService.getUserId();

    QuerySnapshot bagItems = await _shoppingBagReference.where('userId',isEqualTo: uid).get();
    String shoppingBagItemId = bagItems.docs[0].id;

    final TransactionHandler deleteTransaction = (Transaction tx) async{
      final DocumentSnapshot ds = await tx.get(_shoppingBagReference.doc(shoppingBagItemId));
      tx.delete(ds.reference);
    };

    await _firestore.runTransaction(deleteTransaction);
  }
}