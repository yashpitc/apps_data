import 'package:AppsData/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

initializeFirebase() async {
  await Firebase.initializeApp();
  // Pass all uncaught errors from the framework to Crashlytics.
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initializeFirebase();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "users_app",
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    ),
  );
}

