import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/QuestionModel.dart';
import '../../../data/models/SubjectModel.dart';

class DashboardController extends GetxController {

  FirestoreService firestoreService = FirestoreService();
  List subjectList = [];
  List<QuestionModel> questionDataList = [];
  List questionList = [];
  var completedChallenges = 0;
  var lostChallenges = 0;

  @override
  void onInit() {
    super.onInit();
    fetchSubjectId();
  }

  Future fetchSubjectId() async {
    List subjectIdList = [];
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
            // print("subject Id----- "+ subjectId.toString());
            fetchSubjectsQuestions(subjectId);
          }
          update();
        } else {
          // print("document not exist");
          //X return questionList;
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
          Map<String, dynamic> documentData = documentSnapshot.data() as Map<
              String,
              dynamic>;
          // print("documntdata" + documentData.toString());
          subjectList.add(documentData);
          //print("question Data :: " + subjectList.toString());
          for (var item in subjectList.where((
              element) => element["subject_enable"] == true)) {
            print("item------" + item["subject_id"].toString());
            getQuestions(item["subject_id"]);
          }
          update();
          subjectList.clear();
        } else {}
      });
    } catch (e) {
      return null;
    }
    // return questionList;
  }

  Future getQuestions(String subjectId) async {
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
        print("document not exist last---");
      }
    });
  }

  Future addQuestions(List<QuestionModel> list) async {
    for (var item in list) {
      questionList.add(item.question);
    }
    print("questionlist----" + questionList.toString());
  }

}
