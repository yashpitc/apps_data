import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/constants/colors.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
  required this.onTap,
    this.buttonText
  }) : super(key: key);

  final String? buttonText;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0,bottom:15.0 ),
          child: Text(
              buttonText!,
            style: CustomTextStyle.buttonTextStyle,

          ),
        ));
  }
}



