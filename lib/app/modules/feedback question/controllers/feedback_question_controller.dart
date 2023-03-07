import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/QuestionModel.dart';
import '../../../routes/app_pages.dart';
import '../../../services/firebase_service.dart';

class FeedbackQuestionController extends GetxController{
  FirestoreService firestoreService = FirestoreService();
  TextEditingController noteController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final formKey = GlobalKey<FormState>();
  var answerText = "".obs;
  var maxLength = 200;
  var isLoading = false.obs;
  var questionValue = 0.obs;
  RxList questionList = [
    "Did you enjoy this challenge?",
    "What did you do to finish the challenge?",
    "What was difficult for you?"
  ].obs;
  RxList<QuestionModel> questionList2 = <QuestionModel>[].obs;
  var questionText = "".obs;
  var totalQuestionCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedbackQuestions();
  }

  Future fetchFeedbackQuestions() async {
    isLoading.value = true;
    try {
      await firestoreService.db
          .collection("mindfulness_ask_questions")
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot != null) {
         var allData = querySnapshot.docs.map((doc) => doc.data()).toList();
          for(var item in allData){
            questionList2.value.add(QuestionModel.fromJson(item));
          }
          totalQuestionCount.value = questionList2.length;
         isLoading.value = false;
          update();
        } else {
        }
      });
    } catch (e) {
      return null;
    }
  }

   changeQuestionCount(String questionId){
     var question =  questionList2.value[questionValue.value].question;
     if(questionValue.value != (questionList2.value.length) - 1){
      questionValue.value++;
      addFeedBackAnswer(questionId,question!);
    }else{
       addFeedBackAnswer(questionId,question!);
       Get.offAndToNamed(Routes.COMPLETECHALLENGEVIEW);
       noteController.clear();
       Fluttertoast.showToast(
         msg: "Thanks For Your Feedback.",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
       );
    }
   }

  Future addFeedBackAnswer(String questionId, String fQuestion) async {
    final SharedPreferences prefs = await _prefs;
    var deviceID = prefs.getString('device_id');
    var questionid = questionId;
    var question = fQuestion;
    var noteText = noteController.text;
    var answerText = answerController.text;
    var currentDateTime = DateFormat("MMMM, dd, yyyy,hh:mm:ss a").format(DateTime.now());
    await firestoreService.db.collection('mindfullness_users')
        .doc(deviceID)
        .collection("my_challenges")
        .doc(questionid)
        .collection("feedback")
        .doc()
        .set({
      'answer': answerText,
      'note':noteText,
      'question':question,
      'timestamp': currentDateTime})
        .then((document) {
      answerController.clear();
          // print("feedback submitted");
    }).catchError((error) => print('Add failed: $error'));
  }

}