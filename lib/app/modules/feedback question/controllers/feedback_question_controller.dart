import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedbackQuestionController extends GetxController{

  TextEditingController noteController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var remainQuestion = 0.obs;
  var questionList = [].obs;

   changeQuestionCount(){
     for(int i=1; i<4 ;i++){
       remainQuestion.value = i + 1;
     }
     //remainQuestion.value = remainQuestion.value + 1 ;
   }

   changeQuestion(int index) {
     questionList.value[index] = questionList.value[index] + 1;
   }

}