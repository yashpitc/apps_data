
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../services/firebase_service.dart';

class DailyChallengeController extends GetxController {
  String? deviceID;
  FirestoreService firestoreService = FirestoreService();
  var fcmToken = "";

  @override
  void onInit() async {
    super.onInit();
  }

   Future addCompletedChallenge() async {
    await firestoreService.db.collection('mindfullness_users')
         .doc(deviceID)
         .collection("my_challenges")
         .get()
        .then((document) {
          print("document"+ document.docs.toString());
      // firestoreService.db.collection('mindfullness_users')
      //         .doc(deviceID)
      //         .collection("my_challenges")
      //         .add()

    });
   }

}