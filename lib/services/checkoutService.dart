import 'package:app_frontend/services/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutService {
  Firestore _firestore = Firestore.instance;
  UserService _userService = new UserService();

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

  updateAddressData(QuerySnapshot addressData, Map newAddress) async{
    addressData.documents.forEach((DocumentSnapshot doc) async{
      List addressList = doc.data['address'];
      addressList.add(newAddress);
      await _firestore.collection('shippingAddress').document(doc.documentID).setData({'address':addressList},merge: true);
    });
  }


  Future<void> newShippingAddress(Map address) async{
    String uid = await  _userService.getUserId();

    QuerySnapshot data = await _firestore.collection('shippingAddress').where("userId", isEqualTo: uid).getDocuments();

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

    QuerySnapshot docRef = await _firestore.collection('shippingAddress').where('userId',isEqualTo: uid).getDocuments();
    return docRef.documents[0].data['address'];
  }

  Future<void> newCreditCardDetails(String cardNumber, String expiryDate, String cardHolderName) async{
    String uid = await _userService.getUserId();
    QuerySnapshot creditCardData = await _firestore.collection('creditCard').where("cardNumber", isEqualTo: cardNumber).getDocuments();

    print(creditCardData.documents.length);
    if(creditCardData.documents.length == 0){
      await _firestore.collection('creditCard').add({
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
    QuerySnapshot cardData = await _firestore.collection('creditCard').where('userId',isEqualTo: uid).getDocuments();
    String cardNumber;
    cardData.documents.forEach((docRef){
      cardNumber = docRef.data['cardNumber'].toString().replaceAll(new RegExp(r"\s+\b|\b\s"),'');
      cardNumberList.add(cardNumber.substring(cardNumber.length - 4));
    });
    return cardNumberList;
  }
}