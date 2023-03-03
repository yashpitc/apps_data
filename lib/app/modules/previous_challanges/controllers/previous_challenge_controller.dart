import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/PreviousChallengeModel.dart';
import '../../../services/firebase_service.dart';

class PreviousChallengeController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<PreviousChallengeModel> previousChallengeList = [];
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPreviousChallenges();
  }

Future getPreviousChallenges() async {
  final SharedPreferences prefs = await _prefs;
  var deviceId = prefs.getString('device_id');
  isLoading.value = true;
  previousChallengeList.clear();
  try{
    QuerySnapshot querySnapshot = await firestoreService.db.collection('mindfullness_users').doc(deviceId).collection('my_challenges')
        .orderBy("completed_time", descending: true).get();
    List currentChallenge = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(var item in currentChallenge){
      previousChallengeList.add(PreviousChallengeModel.fromJson(item));
    }
    // for(var item in previousChallengeList){
    //   var completedTime = previousChallengeList[1].completedTime.toString();
    //   //var timeago = convertToAgo(completedTime);
    //   print("completedTime-----" + completedTime.toString());
    // //  print("timeago-----" + timeago.toString());
    // }
    isLoading.value = false;
    //print("currentchallege------"+ previousChallengeList.length.toString());
  }catch(e) {}
}


  String timeAgoCustom(String dateTime) {
    DateTime input =
    DateFormat("MMMM, dd, yyyy,hh:mm:ss a").parse(dateTime);
    // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')     // WhatsApp Time Show Status Shimila
    Duration diff = DateTime.now().difference(input);
    print("diff"+  diff.toString());
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${DateFormat.E().add_jm().format(input)}";
    if (diff.inHours > 0)
      return "Today ${DateFormat('jm').format(input)}";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    if (diff.inSeconds > 0)
      return "${diff.inSeconds} ${diff.inSeconds == 1 ? "seconds" : "seconds"} ago";
    return "just now";
  }

  // String convertToAgo(DateTime input){
  //   Duration diff = DateTime.now().difference(input);
  //   if(diff.inDays >= 1){
  //     return '${diff.inDays} day(s) ago';
  //   } else if(diff.inHours >= 1){
  //     return '${diff.inHours} hour(s) ago';
  //   } else if(diff.inMinutes >= 1){
  //     return '${diff.inMinutes} minute(s) ago';
  //   } else if (diff.inSeconds >= 1){
  //     return '${diff.inSeconds} second(s) ago';
  //   } else {
  //     return 'just now';
  //   }
  // }
  //
  String convertToAgo(String dateTime) {
    DateTime input =
    DateFormat("MMMM, dd, yyyy,hh:mm:ss a").parse(dateTime, true);
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

}