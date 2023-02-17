import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/QuestionModel.dart';
import '../../../data/models/SubjectModel.dart';

class DashboardController extends GetxController {

  FirestoreService firestoreService = FirestoreService();
  List subjectList = [];
  List<QuestionModel> questionDataList = [];
  var questionList = [].obs;
  var completedChallenges = 0;
  var lostChallenges = 0;
  var isLoading = false.obs;
  var isColorChange = true.obs;
  var dailyQuestions = [].obs;
  var questionValue = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjectId();
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
           // var index = item["index"];
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
        }
        addQuestions(questionDataList);
        update();
      } else {
        print("document not exist");
      }
    });
  }

  Future addQuestions(List<QuestionModel> list) async {
  isLoading.value = true;
  questionList.value.clear();
    for (var item in list) {
      questionList.value.add(item.question.toString());
    }
    getNextQuestions();
    isLoading.value = false;

    //print("questionlist----" + questionList.toString());
  }

   getNextQuestions() {
     isColorChange.value = !isColorChange.value;
     int chunkSize = 2;
     dailyQuestions.clear();
     for (var i = 0; i < questionList.value.length; i += chunkSize) {
       dailyQuestions.add(questionList.sublist(i, i+chunkSize > questionList.length ? questionList.length : i + chunkSize));
     }
     questionValue.value =  (questionValue.value == 0 ? 1 : 0);
     //print("question valuie ${dailyQuestions.value[0][questionValue.value]}");
     //print("questionList  ${dailyQuestions.value.toString()}");
    }

}
