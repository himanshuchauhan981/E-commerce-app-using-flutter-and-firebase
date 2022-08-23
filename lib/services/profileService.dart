import 'package:app_frontend/services/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  UserService _userService = new UserService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map> getUserProfile() async {
    Map profileDetails = new Map();
    String? uid = await _userService.getUserId();
    if (uid != null) {
      QuerySnapshot profile = await _firestore.collection('users').where('uid', isEqualTo: uid).get();
      profileDetails = profile.docs.map((doc) {
        profileDetails['fullName'] = doc['fullName'];
        profileDetails['mobileNumber'] = doc['mobileNumber'];
      }).toList()[0] as Map;
    }
    return profileDetails;
  }

  Future<QuerySnapshot?> getUserSettings() async {
    String? uid = await _userService.getUserId();
    if (uid != null) {
      QuerySnapshot settings = await _firestore.collection('profileSetting').where('userId', isEqualTo: uid).get();
      return settings;
    } else {
      return null;
    }
  }

  Future<void> updateAccountDetails(String fullName, String mobileNumber) async {
    String? uid = await _userService.getUserId();
    if (uid != null) {
      QuerySnapshot userData = await _firestore.collection('users').where('userId', isEqualTo: uid).get();
      String documentId = userData.docs[0].id;
      return _firestore
          .collection('users')
          .doc(documentId)
          .set({'fullName': fullName, 'mobileNumber': mobileNumber, 'userId': uid});
    }
  }

  Future<void> updateUserSettings(Map settings) async {
    String? uid = await _userService.getUserId();
    if (uid != null) {
      QuerySnapshot? userSettings = await getUserSettings();
      if (userSettings!.docs.length == 0) {
        String documentId = userSettings.docs[0].id;
        await _firestore.collection('profileSetting').doc(documentId).set(
          {
            'newArrivals': settings['newArrivals'],
            'orderUpdates': settings['orderUpdates'],
            'promotions': settings['promotions'],
            'saleAlerts': settings['saleAlerts'],
            'touchId': settings['touchId'],
            'userId': uid
          },
        );
      }
    }
  }
}
