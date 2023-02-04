import 'package:AppsData/app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  FirestoreService firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  Future fetchSubjects() async {
    List questionList = [];
    try {
      await firestoreService.db
          .collection("apps")
          .doc("mindfulness")
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          List subjectList = documentSnapshot.get("subjects");
          print("subjects:"+ subjectList.toString());
          for (var element in subjectList) {
            questionList.add(element);
          }
          return questionList;
        } else {
          return questionList;
        }
      });
    } catch (e) {
      return [];
    }
    return questionList;
  }





}