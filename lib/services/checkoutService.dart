import 'package:app_frontend/services/shoppingBagService.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutService {
  Firestore _firestore = Firestore.instance;
  UserService _userService = new UserService();
  ShoppingBagService _shoppingBagService = new ShoppingBagService();
  CollectionReference _shippingAddressReference = Firestore.instance.collection('shippingAddress');
  CollectionReference _creditCardReference = Firestore.instance.collection('creditCard');
  CollectionReference _shoppingBagReference = Firestore.instance.collection('bags');
  CollectionReference _orderReference = Firestore.instance.collection('orders');

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
    String documentId = addressData.documents[0].documentID;
    List savedAddress = addressData.documents[0].data['address'];
    savedAddress.add(newAddress);
    await _shippingAddressReference.document(documentId).updateData({'address': savedAddress});
  }

  Future<void> newShippingAddress(Map address) async{
    String uid = await  _userService.getUserId();
    QuerySnapshot data = await _shippingAddressReference.where("userId", isEqualTo: uid).getDocuments();
    if(data.documents.length == 0){
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

    QuerySnapshot docRef = await _shippingAddressReference.where('userId',isEqualTo: uid).getDocuments();
    if(docRef.documents.length != 0){
      addressList = docRef.documents[0].data['address'];
    }
    return addressList;

  }

  Future<void> newCreditCardDetails(String cardNumber, String expiryDate, String cardHolderName) async{
    String uid = await _userService.getUserId();
    QuerySnapshot creditCardData = await _creditCardReference.where("cardNumber", isEqualTo: cardNumber).getDocuments();

    if(creditCardData.documents.length == 0){
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
    QuerySnapshot cardData = await _creditCardReference.where('userId',isEqualTo: uid).getDocuments();
    String cardNumber;
    cardData.documents.forEach((docRef){
      cardNumber = docRef.data['cardNumber'].toString().replaceAll(new RegExp(r"\s+\b|\b\s"),'');
      cardNumberList.add(cardNumber.substring(cardNumber.length - 4));
    });
    return cardNumberList;
  }

  Future<void> placeNewOrder(Map orderDetails) async{
    String uid = await _userService.getUserId();
    QuerySnapshot items = await _shoppingBagReference.where('userId',isEqualTo: uid).getDocuments();

    await _orderReference.add({
      'userId': uid,
      'items': items.documents[0].data['products'],
      'shippingAddress': orderDetails['shippingAddress'],
      'shippingMethod': orderDetails['shippingMethod'],
      'price': int.parse(orderDetails['price']),
      'paymentCard': orderDetails['selectedCard']
    });
    
    await _shoppingBagService.delete();
  }

}