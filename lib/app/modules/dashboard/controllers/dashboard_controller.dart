import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

 FirestoreService firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchSubjectId();
  }

  Future<SubjectModel> fetchSubjectId() async {
    List subjectIdList = [];
    try {
      await firestoreService.db
          .collection("apps")
          .doc("TestApp")
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          List subjectList = documentSnapshot.get("subjects");
         print("subjects:"+ subjectList.toString());
          for (var element in subjectList) {
          // subjectIdList.add(element);
            return SubjectModel(subjectID: element);
            print("element---" + subjectIdList[0].subjectID.toString());
            // questionList.add(element);
          }
          fetchSubjectsQuestions(subjectIdList);
          // return questionList;
        } else {
          //X return questionList;
        }
      });
    } catch (e) {
      return SubjectModel();
    }
    return SubjectModel();
  }

  Future fetchSubjectsQuestions(List SubjectIdList) async {
    //List questionList = [];

    try {
      await firestoreService.db
          .collection("subject")
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot != null) {
          List subjectList = documentSnapshot.docs;
          print("subjects:"+ subjectList.toString());
          // for (var element in subjectList) {
          //  return SubjectModel(subjectID: element);
          //   // print("element" + subjectIds.toString());
          //   // questionList.add(element);
          // }
         // return questionList;
        } else {
         //X return questionList;
        }
      });
    } catch (e) {
      return [];
    }
   // return questionList;
  }





}

class SubjectModel {
   int? subjectID;

  SubjectModel({
     this.subjectID,
  });

  SubjectModel.fromMap(DocumentSnapshot data) {
    subjectID = data['subjet_id'];
  }
}
