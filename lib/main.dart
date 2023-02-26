import 'dart:async';

import 'package:AppsData/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/services/firebase_service.dart';
import 'app/services/push_notification.dart';

// initializeFirebase() async {
//   await Firebase.initializeApp();
//   FirestoreService firebaseservice = FirestoreService();
//   firebaseservice.registerDevice();
//   // Pass all uncaught errors from the framework to Crashlytics.
//   //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//
//   FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
// }

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
   //PushNotification().init();
    FirestoreService firestoreService = FirestoreService();
    firestoreService.registerDevice();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "users_app",
        initialRoute: AppPages.INITIAL,
        defaultTransition: Transition.cupertino,
        getPages: AppPages.routes,
      ),
    );
  },(error,stackTrace){
  FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });

}

