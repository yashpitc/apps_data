import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../services/firebase_service.dart';

class DailyChallengeController extends GetxController {

  FirestoreService firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
   var devicetoken = getId();
   print("devicetoken---"+ devicetoken.toString());
    getFcmToken();

  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
   if (Platform.isIOS) {
   var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
   return androidDeviceInfo.id; // unique ID on Android
     }
    }


    Future<String?> getFcmToken() {
    return FirebaseMessaging.instance.getToken().then((token) async{
      print("token" + token.toString());
      //prefs.setString('device_id', deviceId.toString());
      // firestoreService.db.collection(deviceId.toString()).doc(deviceId).set({
      //   'FCM_id':token
      // });
    });

   }



}