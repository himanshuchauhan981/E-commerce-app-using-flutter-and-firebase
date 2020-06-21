import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_frontend/services/userService.dart';

class ProfileService{
  UserService _userService = new UserService();
  Firestore _firestore = Firestore.instance;

  Future<Map> getUserProfile() async{
    Map profileDetails = new Map();
    String uid = await _userService.getUserId();
    QuerySnapshot profileData = await _firestore.collection('users').where('userId',isEqualTo: uid).getDocuments();
    profileDetails['firstName'] = profileData.documents[0].data['firstName'];
    profileDetails['lastName'] = profileData.documents[0].data['lastName'];
    profileDetails['mobileNumber'] = profileData.documents[0].data['mobileNumber'];
    return profileDetails;
  }

  Future<QuerySnapshot> getUserSettings() async{
    String uid = await _userService.getUserId();
    QuerySnapshot profileData = await _firestore.collection('profileSetting').where('userId',isEqualTo: uid).getDocuments();
    return profileData;
  }

  Future<void> updateAccountDetails(String firstName, String lastName, String email, String mobileNumber) async{
    String uid = await _userService.getUserId();
    QuerySnapshot userData = await _firestore.collection('users').where('userId',isEqualTo: uid).getDocuments();
    String documentId = userData.documents[0].documentID;
    await _firestore.collection('users').document(documentId).setData({
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'userId': uid
    });
  }

  Future <void> updateUserSettings(Map settings) async{
    String uid = await _userService.getUserId();
    QuerySnapshot userSettings = await getUserSettings();
    String documentId = userSettings.documents[0].documentID;
    await _firestore.collection('profileSetting').document(documentId).setData({
      'newArrivals': settings['newArrivals'],
      'orderUpdates': settings['orderUpdates'],
      'promotions': settings['promotions'],
      'saleAlerts': settings['saleAlerts'],
      'touchId': settings['touchId'],
      'userId': uid
    });

  }
}