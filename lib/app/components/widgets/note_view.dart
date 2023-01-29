import 'package:AppsData/app/modules/feedback%20question/controllers/feedback_question_controller.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/validations/form_field_validation.dart';
import '../custom/custom_textstyle.dart';

class NoteView extends StatelessWidget {
 NoteView({Key? key,
   required this.controller,
   this.onFieldSubmitted}) : super(key: key);
  FeedbackQuestionController? controller;
  ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child:  TextFormField(
          controller: controller!.noteController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 7,
          cursorColor: AppColors.blackColor,
          cursorWidth: 2,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: "MAKE A NOTE FOR YOURSELF....",
            hintStyle: CustomTextStyle.hintStyle,
            fillColor: AppColors.whiteColor,
            filled: true,
            contentPadding: EdgeInsets.only(top: 20,left: 27,right: 27,bottom: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                  width: 1, color: AppColors.textFieldBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: AppColors.textFieldBorderColor),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: AppColors.textFieldBorderColor),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          validator: (value) => FormFieldValidation().validateText(value!),
          //autovalidateMode: AutovalidateMode.onUserInteraction,
        ));
  }
}
