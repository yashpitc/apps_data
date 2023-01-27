import 'package:AppsData/app/constants/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class CustomRoundButton extends StatelessWidget {
   CustomRoundButton(
      {Key? key,
        required this.icon,
        this.onTap}) : super(key: key);
  String? icon;
  GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height:65,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.whiteColor
        ),
        child: SvgPicture.asset(icon!,
          height: 25,
          width: 25,),
      ),
    );
  }
}
