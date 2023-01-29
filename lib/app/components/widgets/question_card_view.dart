import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/feedback question/controllers/feedback_question_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/validations/form_field_validation.dart';
import '../custom/custom_textstyle.dart';

class QuestionCardView extends StatelessWidget {
  QuestionCardView({Key? key, required this.controller, this.onFieldSubmitted})
      : super(key: key);
  FeedbackQuestionController? controller;
  ValueChanged<String>? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return  Obx(() => Container(
        height: 328,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: 18.0,
              right: 18.0,
              bottom: 6.0,
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                    color: AppColors.appbgColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(24.0))),
              ),
            ),
            Positioned(
              left: 10.0,
              right: 10.0,
              bottom: 15.0,
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  color: AppColors.cardBg2Color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0)),
                ),
              ),
            ),
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: AppColors.cardBgColor,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(blurRadius: 0.1),
                  ],
                ),
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Question  ${controller!.remainQuestion.value}/3", style: CustomTextStyle.questionStyle),
                    const SizedBox(height: 15),
                    Text("Did you enjoy this challenge?",
                        style: CustomTextStyle.questionTitleStyle),
                    const SizedBox(height: 15),
                    Stack(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              top: 4 + (i + 1) * 33,
                            ),
                            height: 2.0,
                            color: AppColors.textFieldBorderColor
                          ),
                        Container(
                          height: 140,
                          child: Form(
                            key: controller!.formKey,
                            child: TextFormField(
                              controller: controller!.answerController,
                             //scrollPadding:const EdgeInsets.only(top:18),
                              decoration: InputDecoration(
                                  hintText: "Your answer...",
                                  hintStyle: CustomTextStyle.hintStyle,
                                 contentPadding: const EdgeInsets.only(top:10,bottom: 10),
                                  border: InputBorder.none),
                              cursorWidth: 2.0,
                              cursorColor: AppColors.blackColor,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 18.0,
                              ),
                              keyboardType: TextInputType.multiline,
                               textInputAction: TextInputAction.newline,
                              expands: true,
                              maxLines: null,
                              validator: (value) => FormFieldValidation().validateText(value!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
