import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/QuestionModel.dart';
import '../../../data/models/SubjectModel.dart';

class DashboardController extends GetxController {

  FirestoreService firestoreService = FirestoreService();
  List subjectList = [];
  List<QuestionModel> questionList = [];

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
          .doc("TestApp")
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          List subjectList = documentSnapshot.get("subjects");
          for (var element in subjectList) {
            var subjectId = element['subjet_id'];
            fetchSubjectsQuestions(subjectId);
          }
        } else {
          print("document not exist");
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
          Map<String, dynamic> documentData = documentSnapshot.data() as Map<String, dynamic>;
          // print("documntdata" + documentData.toString());
          //   documentData['subject_enable'] =
          subjectList.add(documentData);
          print("question Data ::" + subjectList.toString());
          for (var item in subjectList.where((
              element) => element["subject_enable"] == true)) {
            print("item------" + item.toString());
            getQuestions(item["subject_id"]);
          }
          subjectList.clear();
        } else {
        }
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
        .collection("questions")
        .doc(subjectId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        List data = documentSnapshot.get("data");
        print("data" + data.toString());
        // for (var element in data) {
          //questionList.add(QuestionModel.fromJson(data));
       // }
        print("qestionlist-----" + questionList.toString());
      } else {

      }
    });
  }
}
