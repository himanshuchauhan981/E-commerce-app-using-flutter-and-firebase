import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_frontend/services/userService.dart';

class ProfileService{
  UserService _userService = new UserService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map> getUserProfile() async{
    Map profileDetails = new Map();
    String uid = await _userService.getUserId();
    QuerySnapshot profileData = await _firestore.collection('users').where('userId',isEqualTo: uid).get();

    profileDetails['fullName'] = profileData.docs[0].data()['fullName'];
    profileDetails['mobileNumber'] = profileData.docs[0].data()['mobileNumber'];
    return profileDetails;
  }

  Future<QuerySnapshot> getUserSettings() async{
    String uid = await _userService.getUserId();
    QuerySnapshot profileData = await _firestore.collection('profileSetting').where('userId',isEqualTo: uid).get();
    return profileData;
  }

  Future<void> updateAccountDetails(String fullName, String mobileNumber) async{
    String uid = await _userService.getUserId();
    QuerySnapshot userData = await _firestore.collection('users').where('userId',isEqualTo: uid).get();
    String documentId = userData.docs[0].id;

    return _firestore.collection('users').doc(documentId).set({
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'userId': uid
    });
  }

  Future <void> updateUserSettings(Map settings) async{
    String uid = await _userService.getUserId();
    QuerySnapshot userSettings = await getUserSettings();
    String documentId = userSettings.docs[0].id;
    await _firestore.collection('profileSetting').doc(documentId).set({
      'newArrivals': settings['newArrivals'],
      'orderUpdates': settings['orderUpdates'],
      'promotions': settings['promotions'],
      'saleAlerts': settings['saleAlerts'],
      'touchId': settings['touchId'],
      'userId': uid
    });

  }
}