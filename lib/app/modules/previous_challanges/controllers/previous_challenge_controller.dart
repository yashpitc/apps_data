import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/PreviousChallengeModel.dart';
import '../../../services/firebase_service.dart';

class PreviousChallengeController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<PreviousChallengeModel> previousChallengeList = [];
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPreviousChallenges();
  }

Future getPreviousChallenges() async {
  final SharedPreferences prefs = await _prefs;
  var deviceId = prefs.getString('device_id');
  isLoading.value = true;
  try{
    QuerySnapshot querySnapshot = await firestoreService.db.collection('mindfullness_users').doc(deviceId).collection('my_challenges').get();
    List currentChallenge = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(var item in currentChallenge){
      previousChallengeList.add(PreviousChallengeModel.fromJson(item));
    }
    isLoading.value = false;
    //print("currentchallege------"+ previousChallengeList.length.toString());
  }catch(e) {}

}


}