

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';


/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  if (message.data.isNotEmpty) {
    if(Platform.isAndroid){
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.data["title"],
        message.data["body"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            importance: Importance.max,
            icon: 'ic_icon',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }

  }

}*/
/// Create a [AndroidNotificationChannel] for heads up notifications
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//    'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

/// Initialize the [FlutterLocalNotificationsPlugin] package.
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();


class PushNotification {

  Future<void> init() async {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    initializeFirebaseMessaging();
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);


    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //     IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
  }

  // Future<void> checkDataForPushNotification(String deviceId) async{
  //   print("checkDataForPushNotification called");
  //   print(deviceId);
  //   QuerySnapshot snapshot =await FirebaseFirestore.instance.collection(deviceId.toString()).doc(deviceId).collection('Mantra').get();
  //   QuerySnapshot snapshotNotification =await FirebaseFirestore.instance.collection(deviceId.toString()).doc(deviceId).collection('Notifications').get();
  //   List<MantraModel> mantraList  =[];
  //   snapshot.docs.forEach((element) {
  //     mantraList.add(MantraModel(element.id,
  //       element.get('name'),
  //       element.get('target_malas'),
  //       element.get('target_counts'),
  //       element.get('current_malas'),
  //       element.get('current_counts'),
  //       element.get('last_counts'),
  //       element.get('total_days'),
  //       DateTime.fromMillisecondsSinceEpoch(element.get('date_time')),
  //     ));
  //   });
  //   mantraList.forEach((element) {
  //     print(DateTime.now().difference(element.mantraDate).inHours);
  //     if(DateTime.now().difference(element.mantraDate).inHours>24){
  //       if(element.currentCounts < 108){
  //         bool requireNotificationCase1 =true;
  //         snapshotNotification.docs.forEach((notyElement) {
  //           if(notyElement.get('mantra_id') ==element.docId){
  //             if(notyElement.get('notification_type') == 'case_1'){
  //               DateTime lastUpdate =DateTime.fromMillisecondsSinceEpoch(notyElement.get('date_time'));
  //               if(DateTime.now().difference(lastUpdate).inHours<12){
  //                 requireNotificationCase1 =false;
  //               }
  //             }
  //           }
  //         });
  //         if(requireNotificationCase1){
  //           sendPushNotification(deviceId,"case_1",element.docId,element.mantraName+' is not started yet', "Please start mantra counter and complete your daily target", Random().nextInt(50000000));
  //         }
  //       }
  //     }
  //     int remainingDays =element.totalDays - DateTime.now().difference(element.mantraDate).inDays;
  //     print(remainingDays);
  //     if(remainingDays <3){
  //       int perDayCount= element.targetCounts~/element.totalDays;
  //       if(element.targetCounts - element.currentCounts>(perDayCount*remainingDays)){
  //         bool requireNotificationCase1 =true;
  //         snapshotNotification.docs.forEach((notyElement) {
  //           if(notyElement.get('mantra_id') ==element.docId){
  //             if(notyElement.get('notification_type') == 'case_2'){
  //               DateTime lastUpdate =DateTime.fromMillisecondsSinceEpoch(notyElement.get('date_time'));
  //               if(DateTime.now().difference(lastUpdate).inHours<12){
  //                 requireNotificationCase1 =false;
  //               }
  //             }
  //           }
  //         });
  //         if(requireNotificationCase1){
  //           sendPushNotification(deviceId,"case_2",element.docId,'$remainingDays remaining to complete ${element.mantraName}', "Please continue mantra counter and complete your target before end-date", Random().nextInt(50000000));
  //         }
  //       }
  //     }
  //   });
  // }


  void initializeFirebaseMessaging() {

    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        if(Platform.isAndroid){
          flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.data["title"],
            message.data["body"],
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  importance: Importance.max,
                  icon: 'ic_icon',
                ),
            ),
            payload: jsonEncode(message.data),
          );
        }
      }
    });*/
  }

  // void sendPushNotification(String deviceId,String notificationType,String docId,String title, String body, int id){
  //   FirebaseFirestore.instance.collection(deviceId.toString()).doc(deviceId).collection('Notifications').add({
  //     'notification_type':notificationType,
  //     'mantra_id':docId,
  //     'date_time':DateTime.now().millisecondsSinceEpoch,
  //     'title':title,
  //     'body':body,
  //   });
  //   flutterLocalNotificationsPlugin.show(
  //     id,
  //     title,
  //     body,
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         channel.description,
  //         importance: Importance.max,
  //         icon: 'ic_icon',
  //       ),
  //     ),
  //   );
  // }

}



