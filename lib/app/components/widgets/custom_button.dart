import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
  required this.onTap,
    this.buttonText,
    this.contentPadding

  }) : super(key: key);

  final String? buttonText;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
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
          padding: contentPadding!,
          child: Text(
              buttonText!,
            style: CustomTextStyle.buttonTextStyle,

          ),
        ));
  }
}



