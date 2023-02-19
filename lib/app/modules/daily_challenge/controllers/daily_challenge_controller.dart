import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void onInit() async {
    super.onInit();
  }

  Future updateCompletedChallenge(QuestionModel data) async {
    final SharedPreferences prefs = await _prefs;
    var questionid = data.id;
    var question = data.question;
    var currentDateTime = DateFormat("MMMM, dd, yyyy,hh:mm:ss a").format(DateTime.now());
    deviceID = prefs.getString('device_id');
    await firestoreService.db
        .collection('mindfullness_users')
        .doc(deviceID)
        .collection("my_challenges")
        .doc(questionid)
        .update({
      'completed_time': currentDateTime,
      'type': 'completed'})
        .then((document) {
      Fluttertoast.showToast(
        msg: "Congratulations! You have Completed Challenge",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      Get.offAndToNamed(Routes.FEEDBACKQUESTIONVIEW);
    }).catchError((error) => print('Add failed: $error'));
  }

 /* Future addCurrentChallenge(QuestionModel data) async {
    final SharedPreferences prefs = await _prefs;
    var questionid = data.id;
    var question = data.question;
    var curentDateTime = DateFormat("MMMM, dd, yyyy,hh:mm:ss a").format(DateTime.now());
    deviceID = prefs.getString('device_id');
    await firestoreService.db
        .collection('mindfullness_users')
        .doc(deviceID)
        .collection("my_challenges")
        .doc(questionid)
        .set({
      'completed_time': '',
      'id': questionid,
      'start_time': curentDateTime,
      'question': question,
      'type': 'current'
    }).then((document) {
      Fluttertoast.showToast(
        msg: "Challenge Started",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }).catchError((error) => print('Add failed: $error'));
  }*/


}
