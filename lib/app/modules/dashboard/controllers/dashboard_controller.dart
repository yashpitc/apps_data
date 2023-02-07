import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

 FirestoreService firestoreService = FirestoreService();
 List questionList = [];
 
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
      //  print("subjects:"+ subjectList.toString());
          for (var element in subjectList) {
            var subjectId = element['subjet_id'];
          //  print("element----"+ element["subjet_id"].toString());
         // subjectIdList.add(element['subjet_id']);
          //  return SubjectModel(subjectID: element);
           // print("element---" + subjectIdList[0].subjectID.toString());
          fetchSubjectsQuestions(subjectId);
            // questionList.add(element);
          }

          // return questionList;
        } else {
          print("document not exist");
          //X return questionList;
        }
      });
    } catch (e) {
    }
  }

  Future fetchSubjectsQuestions(String subjectId) async {

    try {
      await firestoreService.db
          .collection("subject")
          .doc(subjectId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Object? documentData = documentSnapshot.data();
        // bool trendIndex = documentData.indexWhere((f) => f['name'] == trendName);
          questionList.add(documentData);

         // questionList.add(documentSnapshot.data());
          print("question Data" + questionList.toString());
          // for (int i = 0; i < documentSnapshot.docs.length; i++) {
          //   var a = documentSnapshot.docs[i];
          //   print(a.documentID);
          // }
          //print("subjects:"+ documentSnapshot.data().toString());
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
      return null;
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
