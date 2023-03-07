import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:AppsData/app/modules/feedback%20question/controllers/feedback_question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/widgets/custom_button.dart';
import '../../../components/widgets/note_view.dart';
import '../../../components/widgets/question_card_view.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/validations/form_field_validation.dart';

class FeedbackQuestionView extends StatelessWidget {
  FeedbackQuestionView({Key? key}) : super(key: key);
  var questionID = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print("questionID----"+ questionID.toString());
    return Scaffold(
      backgroundColor: AppColors.dashboardBGColor,
      body: GetBuilder<FeedbackQuestionController>(
          init: FeedbackQuestionController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 70,left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NoteView(controller: controller),
                  const SizedBox(height: 50),
                  QuestionCardView(controller: controller),
                  const SizedBox(height: 50),
                  CustomButton(
                      buttonText: "NEXT",
                      contentPadding: EdgeInsets.only(left: 45,right: 45,top: 15,bottom: 15),
                      onTap: () {
                        if (controller.formKey.currentState!.validate()){
                          controller.changeQuestionCount(questionID);
                        }else{
                          showSnackBar("Answer can't be empty",context);
                        }
                      }),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
      ),
    );
  }

  showSnackBar(String text,BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(color: AppColors.blackColor)),
        backgroundColor: AppColors.whiteColor,
      ),
    );
  }


}
