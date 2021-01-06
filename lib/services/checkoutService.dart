import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_frontend/services/shoppingBagService.dart';
import 'package:app_frontend/services/userService.dart';

class CheckoutService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserService _userService = new UserService();
  ShoppingBagService _shoppingBagService = new ShoppingBagService();
  CollectionReference _shippingAddressReference = FirebaseFirestore.instance.collection('shippingAddress');
  CollectionReference _creditCardReference = FirebaseFirestore.instance.collection('creditCard');
  CollectionReference _shoppingBagReference = FirebaseFirestore.instance.collection('bags');
  CollectionReference _orderReference = FirebaseFirestore.instance.collection('orders');
  CollectionReference _productReference = FirebaseFirestore.instance.collection('products');

  Map mapAddressValues(Map values){
    Map addressValues = new Map();
    addressValues['area'] = values['area'];
    addressValues['city'] = values['city'];
    addressValues['landmark'] = values['landMark'];
    addressValues['state'] = values['state'];
    addressValues['address'] = values['address'];
    addressValues['name'] = values['fullName'];
    addressValues['mobileNumber'] = values['mobileNumber'];
    addressValues['pinCode'] = values['pinCode'];
    return addressValues;
  }

  Future<void>updateAddressData(QuerySnapshot addressData, Map newAddress) async{
    String documentId = addressData.docs[0].id;
    List savedAddress = addressData.docs[0].data()['address'];
    savedAddress.add(newAddress);
    await _shippingAddressReference.doc(documentId).update({'address': savedAddress});
  }

  Future<void> newShippingAddress(Map address) async{
    String uid = await  _userService.getUserId();
    QuerySnapshot data = await _shippingAddressReference.where("userId", isEqualTo: uid).get();
    if(data.docs.length == 0){
      await _firestore.collection('shippingAddress').add({
        'userId': uid,
        'address': [mapAddressValues(address)]
      });
    }
    else{
      await updateAddressData(data,address);
    }
  }

  Future<List> listShippingAddress() async{
    String uid = await _userService.getUserId();
    List addressList = new List();

    QuerySnapshot docRef = await _shippingAddressReference.where('userId',isEqualTo: uid).get();
    if(docRef.docs.length != 0){
      addressList = docRef.docs[0].data()['address'];
    }
    return addressList;

  }

  Future<void> newCreditCardDetails(String cardNumber, String expiryDate, String cardHolderName) async{
    String uid = await _userService.getUserId();
    QuerySnapshot creditCardData = await _creditCardReference.where("cardNumber", isEqualTo: cardNumber).get();

    if(creditCardData.docs.length == 0){
      await _creditCardReference.add({
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'userId': uid
      });
    }
  }

  Future<List> listCreditCardDetails() async{
    String uid = await _userService.getUserId();
    List<String> cardNumberList = new List<String>();
    QuerySnapshot cardData = await _creditCardReference.where('userId',isEqualTo: uid).get();
    String cardNumber;
    cardData.docs.forEach((docRef){
      cardNumber = docRef.data()['cardNumber'].toString().replaceAll(new RegExp(r"\s+\b|\b\s"),'');
      cardNumberList.add(cardNumber.substring(cardNumber.length - 4));
    });
    return cardNumberList;
  }

  Future<void> placeNewOrder(Map orderDetails) async{
    String uid = await _userService.getUserId();
    QuerySnapshot items = await _shoppingBagReference.where('userId',isEqualTo: uid).get();

    await _orderReference.add({
      'userId': uid,
      'items': items.docs[0].data()['products'],
      'shippingAddress': orderDetails['shippingAddress'],
      'shippingMethod': orderDetails['shippingMethod'],
      'price': int.parse("${orderDetails['price']}"),
      'paymentCard': orderDetails['selectedCard'],
      'placedDate': DateTime.now()
    });
    
    await _shoppingBagService.delete();
  }
  
  Future<List> listPlacedOrder() async {
    List orderList = new List();
    String uid = await _userService.getUserId();
    QuerySnapshot orders = await _orderReference.orderBy('placedDate',descending: true).where('userId', isEqualTo: uid).get();
    for(DocumentSnapshot order in orders.docs) {
      Map orderMap = new Map();
      orderMap['orderDate'] = order.data()['placedDate'];
      List orderData = new List();
      for (int i = 0; i < order.data()['items'].length; i++) {
        Map tempOrderData = new Map();
        tempOrderData['quantity'] = order.data()['items'][i]['quantity'];
        DocumentSnapshot docRef = await _productReference.doc(order.data()['items'][i]['id']).get();
        tempOrderData['productImage'] = docRef.data()['image'][0];
        tempOrderData['productName'] = docRef.data()['name'];
        tempOrderData['price'] = docRef.data()['price'];
        orderData.add(tempOrderData);
      }
      orderMap['orderDetails'] = orderData;
      orderList.add(orderMap);
    }
    return orderList;
  }

}