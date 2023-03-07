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
    var dHeight = MediaQuery.of(context).size.height;
    var question = controller!.questionList2.value.map((element) => element.question);
    return  Obx(() => Container(
        height: dHeight > 800 ? 400 : 328,
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
                height: dHeight > 800 ? 375 : 300,
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
                    Text("Question  ${controller!.questionValue.value + 1}/${controller!.totalQuestionCount.value}", style: CustomTextStyle.questionStyle),
                    const SizedBox(height: 15),
                    Flexible(
                      child:
                      controller!.isLoading.value?
                      SizedBox():
                      Text(
                          controller!.questionList2[controller!.questionValue.value].question.toString(),
                          style: CustomTextStyle.questionTitleStyle),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: controller!.formKey,
                      child: TextFormField(
                        controller: controller!.answerController,
                       maxLength: controller!.maxLength,
                        decoration: InputDecoration(
                            hintText: "Your answer...",
                            hintStyle: CustomTextStyle.hintStyle,
                           contentPadding:  EdgeInsets.all(10.0),
                          filled: true,
                          fillColor: AppColors.textFieldBgColor,
                            counterText: '${controller!.answerText.value.length.toString() + "/" + controller!.maxLength.toString() } characters',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                width: 0, color: AppColors.textFieldBgColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: AppColors.textFieldBgColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: AppColors.textFieldBgColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: AppColors.textFieldBgColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0, color: AppColors.textFieldBgColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        cursorWidth: 2.0,
                        cursorColor: AppColors.blackColor,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18.0,
                        ),
                        maxLines: dHeight > 800 ? 6 :  4,
                        keyboardType: TextInputType.multiline,
                         textInputAction: TextInputAction.newline,
                        validator: (value) => FormFieldValidation().validateText(value!),
                        onChanged: (value) {
                          controller!.answerText.value = value;
                        },

                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }


}
