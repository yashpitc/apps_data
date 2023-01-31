import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedbackQuestionController extends GetxController{

  TextEditingController noteController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var remainQuestion = 1.obs;
  var answerText = "".obs;
  var maxLength = 200;
  RxList questionList = [
    "Did you enjoy this challenge?",
    "What did you do to finish the challenge?",
    "What was difficult for you?"
  ].obs;
  var questionText = "".obs;


   changeQuestionCount(){
     // for(int i=1; i<4 ;i++){
     //   remainQuestion.value = i + 1;
     // }
     remainQuestion.value = remainQuestion.value + 1 ;
   }

   changeQuestion(int index) {
       questionText.value = questionList.value[index + 1];
   }

}