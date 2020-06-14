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
    return profileDetails;
  }

  Future<QuerySnapshot> getUserSettings() async{
    String uid = await _userService.getUserId();
    QuerySnapshot profileData = await _firestore.collection('profileSetting').where('userId',isEqualTo: uid).getDocuments();
    return profileData;
  }
}