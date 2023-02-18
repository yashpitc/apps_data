import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Future registerDevice() async {
    final SharedPreferences prefs = await _prefs;
    String? deviceId;
    if(prefs.containsKey('device_id')){
      deviceId = prefs.getString('device_id');
    }else{
      deviceId = await _getDeviceId();
    }
    prefs.setString('device_id', deviceId.toString());
    FirebaseMessaging.instance.getToken().then((token) async {
      prefs.setString('fcm_token', token!);
      bool docExists = await checkIfDocExists(deviceId.toString());
      if(docExists){
          FirebaseFirestore.instance.collection("mindfullness_users").doc(deviceId).update({
        'fcm_token':token
      });
      }else {
        FirebaseFirestore.instance.collection("mindfullness_users").doc(deviceId).set({
          'fcm_token':token,
          // 'timestamp': D
        });
      }
    });
  }

  Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = _firestoreService.db.collection('mindfullness_users');
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
}