import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/PreviousChallengeModel.dart';
import '../../../data/models/QuestionModel.dart';
import '../../../data/models/SubjectModel.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  //final dbController = Get.put(DashboardController());
  FirestoreService firestoreService = FirestoreService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List subjectList = [];
  List<QuestionModel> questionDataList = [];
  var userQuestionList = <QuestionModel>[].obs;
  var completedChallenges = 0;
  var lostChallenges = 0;
  var isLoading = false.obs;
  var isColorChange = false.obs;
  var dailyQuestions = [].obs;
  var questionValue = 0.obs;
  var completeChallengeCount = 0.obs;
  var lostChallengeCount = 0.obs;
  var totalChallengeCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    checkCurrentChallenge();
  }

  Future checkCurrentChallenge() async {
    final SharedPreferences prefs = await _prefs;
    var deviceId = prefs.getString('device_id');
    isLoading.value = true;
    try{
      QuerySnapshot querySnapshot = await firestoreService.db.collection('mindfullness_users').doc(deviceId).collection('my_challenges').where('type', isEqualTo: "current").get();
      List currentChallenge = querySnapshot.docs.map((doc) => doc.data()).toList();
      if(currentChallenge.isNotEmpty){
        userQuestionList.value.add(QuestionModel.fromJson(currentChallenge[0]));
        isLoading.value = false;
        Get.offAndToNamed(Routes.DAILYCHALLENGEVIEW,arguments: this);
      } else{
        updateChallengeCount();
        fetchSubjectId();
      }
    }catch(e) {}
  }

  Future updateChallengeCount() async {
    final SharedPreferences prefs = await _prefs;
    var deviceId = prefs.getString('device_id');
    try {
      var completedCount = await firestoreService.db.collection('mindfullness_users').doc(deviceId).collection('my_challenges').where('type', isEqualTo: "completed").get();
      var lostCount = await firestoreService.db.collection('mindfullness_users').doc(deviceId).collection('my_challenges').where('type', isEqualTo: "lost").get();
      FirebaseFirestore.instance.collection("mindfullness_users").doc(deviceId).update({
        'completed_challenges_count':completedCount.docs.length,
        'lost_challenges_count':lostCount.docs.length,
      });
      Map<String, dynamic> data = await firestoreService.db.collection('mindfullness_users').doc(deviceId).get().then((value) => value.data()) as Map<String, dynamic>;
      completeChallengeCount.value = data['completed_challenges_count'];
      lostChallengeCount.value = data["lost_challenges_count"];
      update();
    }catch(e) {}
  }



  Future fetchSubjectId() async {
    isLoading.value = true;
    try {
      await firestoreService.db
          .collection("apps")
          .doc("mindfulness")
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          List subjectList = documentSnapshot.get("subjects");
          for (var element in subjectList) {
            var subjectId = element['subjet_id'];
            fetchSubjectsQuestions(subjectId);
          }
          update();
        } else {
          // print("document not exist");
        }
      });
    } catch (e) {}
  }

  Future fetchSubjectsQuestions(String subjectId) async {
    subjectList.clear();
    try {
      await firestoreService.db
          .collection("subject")
          .doc(subjectId)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> documentData = documentSnapshot.data() as Map<String, dynamic>;
          subjectList.add(documentData);
          for (var item in subjectList.where((element) => element["subject_enable"] == true)) {
            getQuestions(item["subject_id"]);
          }
          update();
          subjectList.clear();
        } else {
        }
      });
    } catch (e) {
      return null;
    }
  }

  Future getQuestions(String subjectId) async {
    isLoading.value = true;
    await firestoreService.db
        .collection("subject")
        .doc(subjectId)
        .collection("question")
        .doc(subjectId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        List data = documentSnapshot.get("data");
        for (var element in data) {
          questionDataList.add(QuestionModel.fromJson(element));
          addQuestions(QuestionModel.fromJson(element));
        }
        totalChallengeCount.value = questionDataList.length;
      //addQuestions(questionDataList);
        update();
      } else {
        print("document not exist");
      }
    });
  }

  Future addQuestions(QuestionModel allQuestionList) async {
    final SharedPreferences prefs = await _prefs;
    var deviceId = prefs.getString('device_id');
    isLoading.value = true;
    userQuestionList.value.clear();
  try{
    QuerySnapshot querySnapshot = await firestoreService.db.collection('mindfullness_users').doc(deviceId).collection('my_challenges').get();
    List currentChallenge = querySnapshot.docs.map((doc) => doc.data()).toList();
      // print("currentchallanges  $currentChallenge");
    if(currentChallenge.isNotEmpty) {
       // for(var item in currentChallenge) {
       //   bool exist = allQuestionList.asMap().containsValue(item["id"]);
       //   print("exist----" + exist.toString());
       //    // if(allQuestionList.contains("id")){
       //    //   print("contains"+ item["id"]);
       //      //userQuestionList.value.add(item);
       //    // }else{
       //    //  print("not contains"+ item["id"]);
       //    // }
       // }
      // print("userQuestionList++++"+ userQuestionList.toString());
      for(var item in currentChallenge) {
        // print("question Id " + question.id.toString());
        // print("use completed Id " + item.toString());
        // print("item type${item["type"]}");
        // print("item type ${item["type"].runtimeType}");
        if ( item["id"] == allQuestionList.id) {
          userQuestionList.value.add(allQuestionList);
          // questionList.value.removeWhere((element) => element.questionType == "completed");
          print("not completed statement" + userQuestionList.toString());
        }
      }
      // }
      update();
    }else {
      print("else part");
     // questionList.add(question);
      print("questionList2-----$userQuestionList");
    }
    isLoading.value = false;
  }catch(e){}
  }


   getNextQuestions() {
     isColorChange.value = !isColorChange.value;
     int chunkSize = 2;
     dailyQuestions.clear();
     for (var i = 0; i < userQuestionList.length; i += chunkSize) {
       dailyQuestions.add(userQuestionList.sublist(i, i+chunkSize > userQuestionList.length ? userQuestionList.length : i + chunkSize));
     }
    questionValue.value =  (questionValue.value == 0 ? 1 : 0);
    // print("question value ${dailyQuestions.value[0][questionValue.value]}");
    }

   Future getChallengeCount() async {
     final SharedPreferences prefs = await _prefs;
     var deviceId = prefs.getString('device_id');
     try {
       await firestoreService.db.collection('mindfullness_users')
           .doc(deviceId)
           .get()
           .then((DocumentSnapshot document) {
         if (document.exists) {
           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
           completeChallengeCount.value = data['completed_challenges_count'];
           lostChallengeCount.value = data["lost_challenges_count"];
         } else {
           completeChallengeCount.value = 0;
           lostChallengeCount.value = 0;
         }
       });
     }catch(e) {
       completeChallengeCount.value = 0;
       lostChallengeCount.value = 0;
     }
    }


  Future addCurrentChallenge(QuestionModel data) async {
    final SharedPreferences prefs = await _prefs;
    var deviceID = prefs.getString('device_id');
    var questionid = data.id;
    var question = data.question;
    var currentDateTime = DateFormat("MMMM, dd, yyyy,hh:mm:ss a").format(DateTime.now());
    await firestoreService.db.collection('mindfullness_users')
        .doc(deviceID)
        .collection("my_challenges")
        .doc(questionid)
        .set({
      'completed_time': '',
      'id':questionid,
      'start_time':currentDateTime,
      'question':question,
      'type': 'current'})
        .then((document) {
      Get.toNamed(Routes.DAILYCHALLENGEVIEW,arguments: DashboardController);
      Fluttertoast.showToast(
        msg: "Challenge Started",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      }).catchError((error) => print('Add failed: $error'));
  }

}
