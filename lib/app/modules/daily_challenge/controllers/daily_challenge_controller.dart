import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/QuestionModel.dart';
import '../../../routes/app_pages.dart';
import '../../../services/firebase_service.dart';

class DailyChallengeController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? deviceID;
  var fcmToken = "";
  var questionValue = 1.obs;
  String challengeStartTime = "";
  var challengeLeftTime = "00:00".obs;
  var challengeLeftPercentage = 0.0.obs;
  var challengeLeftHours = 0.obs;
  String currentChallengeId = "";

  @override
  void onInit() async {
    super.onInit();
    getRemainingTime();
  }

  Future updateCompletedChallenge(QuestionModel data) async {
    final SharedPreferences prefs = await _prefs;
    var questionid = data.id;
    var question = data.question;
    var currentDateTime =
        DateFormat("MMMM, dd, yyyy,hh:mm:ss a").format(DateTime.now());
    deviceID = prefs.getString('device_id');
    await firestoreService.db
        .collection('mindfullness_users')
        .doc(deviceID)
        .collection("my_challenges")
        .doc(questionid)
        .update({'completed_time': currentDateTime, 'type': 'completed'}).then(
            (document) {
      Fluttertoast.showToast(
        msg: "Congratulations! You have Completed Challenge",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      Get.offAndToNamed(Routes.FEEDBACKQUESTIONVIEW);
    }).catchError((error) => print('Add failed: $error'));
  }


  Future updateLostChallenge(String questionId) async {
    final SharedPreferences prefs = await _prefs;
    var currentDateTime =
    DateFormat("MMMM, dd, yyyy,hh:mm:ss a").format(DateTime.now());
    deviceID = prefs.getString('device_id');
    await firestoreService.db
        .collection('mindfullness_users')
        .doc(deviceID)
        .collection("my_challenges")
        .doc(questionId)
        .update({'completed_time': currentDateTime, 'type': 'lost'}).then(
            (document) {
          Fluttertoast.showToast(
            msg: "oops! You have lost your Challenge",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          Get.offAndToNamed(Routes.FEEDBACKQUESTIONVIEW);
        }).catchError((error) => print('Add failed: $error'));
  }

  Future getRemainingTime() async {
    final SharedPreferences prefs = await _prefs;
    var deviceId = prefs.getString('device_id');
    try {
      QuerySnapshot querySnapshot = await firestoreService.db
          .collection('mindfullness_users')
          .doc(deviceId)
          .collection('my_challenges')
          .where('type', isEqualTo: "current")
          .get();
      List currentChallenge = querySnapshot.docs.map((doc) => doc.data()).toList();
      if (currentChallenge.isNotEmpty) {
          challengeStartTime = currentChallenge[0]["start_time"];
          currentChallengeId =  currentChallenge[0]["id"];
          challengeLeftHours.value = timeCalculator(challengeStartTime);
          print("challengeLeftHours--${challengeLeftHours.value}");
           if(challengeLeftHours.value >= 24){
             challengeLeftTime.value = "24:00";
             challengeLeftPercentage.value = 1.0;
            await Future.delayed(const Duration(seconds: 3));
            updateLostChallenge(currentChallengeId);
           }else{
             challengeLeftTime.value = checkChallengeLeftTime(challengeStartTime);
             challengeLeftPercentage.value = getPercentageFromTime(challengeLeftTime.value);
           }
      }else{
        challengeLeftTime.value = "00:00";
        challengeLeftPercentage.value = 00.00;
      }
    } catch (e) {

    }
  }

  String checkChallengeLeftTime(String startTime) {
    final now = DateTime.now();
    DateFormat formatter = DateFormat("MMMM, dd, yyyy,hh:mm:ss a");
    DateTime dateTime = formatter.parse(startTime);
    int endDay = dateTime.day;
    int endDayHour = dateTime.hour;
    int endDayMinute = dateTime.minute;
    int endDaySecond = dateTime.second;
    final endOfToday = DateTime(now.year, now.month, endDay + 1, endDayHour, endDayMinute);
    final spendTime = now.subtract(Duration(hours: endDayHour, minutes: endDayMinute)).toString();
    final spendTimeUtc = now.subtract(Duration(hours: endDayHour, minutes: endDayMinute)).toUtc();
    String timeSpentStr = spendTime.toString().substring(11, 16);
    return timeSpentStr;
  }

  String checkChallengeFullTime(String startTime) {
    final now = DateTime.now();
    DateFormat formatter = DateFormat("MMMM, dd, yyyy,hh:mm:ss a");
    DateTime dateTime = formatter.parse(startTime);
    int endDay = dateTime.day;
    int endDayHour = dateTime.hour;
    int endDayMinute = dateTime.minute;
    int endDaySecond = dateTime.second;
    final endOfToday = DateTime(now.year, now.month, endDay + 1, endDayHour, endDayMinute);
    final spendTime = now.subtract(Duration(hours: endDayHour, minutes: endDayMinute)).toString();
    final spendTimeUtc = now.subtract(Duration(hours: endDayHour, minutes: endDayMinute)).toUtc();
    String timeSpentStr = spendTime.toString();
    return timeSpentStr;
  }

  String checkChallengeCompleteTime(String startTime) {
    final now = DateTime.now();
    DateFormat formatter = DateFormat("MMMM, dd, yyyy,hh:mm:ss a");
    DateTime dateTime = formatter.parse(startTime);
    int endDay = dateTime.day;
    int endDayHour = dateTime.hour;
    int endDayMinute = dateTime.minute;
    int endDaySecond = dateTime.second;
    final endOfToday = DateTime(now.year, now.month, endDay + 1, endDayHour, endDayMinute);
    return endOfToday.toString();
  }

  int timeCalculator(String startTime) {
    DateFormat formatter = DateFormat("MMMM, dd, yyyy,hh:mm:ss a");
    DateTime dateTime = formatter.parse(startTime);
    final now = DateTime.now().toUtc();
    final difference = now.difference(dateTime).inHours;
    // print(">>>>>>>>>>>>>>>>RunningTime ${hoursCalculator(difference.inMinutes)}");
    // print(">>>>>>>>>>>>>>>>RemainingTime ${hoursCalculator(1440 - difference.inMinutes)}");
    return difference;
  }

  String hoursCalculator(int min) {
    int hours = min ~/ 60;
    int remainingMinutes = min % 60;
    String formattedTime =
        '$hours:${remainingMinutes.toString().padLeft(2, '0')}';
    return formattedTime;
  }


  double getPercentageFromTime(String leftTime) {
    DateFormat formatter = DateFormat("HH:mm");
    DateTime dateTime = formatter.parse(leftTime);
    Duration total = const Duration(hours: 24);
    Duration left = Duration(hours: dateTime.hour, minutes: dateTime.minute,seconds: dateTime.second);
    //get percentage between 0.0 to 1.0
    final percentage = left.inMinutes * 1 / 1440;
    //get percentage between 0.0 to 100.0
    final pr = (left.inSeconds / total.inSeconds * 100).truncate();
    return percentage;
  }

}
