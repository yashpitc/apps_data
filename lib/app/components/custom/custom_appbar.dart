import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/constants/colors.dart';
import 'package:AppsData/app/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      required this.firstTitle,
      required this.secondTitle,
      required this.notiButton,
      required this.backbutton,
      this.notiOnTap});

  String? firstTitle;
  String? secondTitle;
  bool? backbutton;
  bool? notiButton;
  List<Widget>? actions;
  GestureTapCallback? notiOnTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backbutton!
          ? IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            )
          : null,
      leadingWidth: 0.0,
      title:  buildTextTitle(firstTitle!, secondTitle!),
      backgroundColor: AppColors.dashboardBGColor,
      elevation: 0.0,
      actions:[
        notiButton!
            ? IconButton(
                onPressed: notiOnTap,
                icon: SvgPicture.asset(AppIcons.bellIconSvg))
            : const SizedBox()
      ],
    );
  }

  buildTextTitle(String firstTitle, String secondTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 0.0,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.firstTitleColor,
                width: 1.8,
              ),
            ),
          ),
          child: Text(firstTitle, style: CustomTextStyle.appbarFirstTitleStyle),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 0.0,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.whiteColor,
                width: 1.8,
              ),
            ),
          ),
          child:
              Text(secondTitle, style: CustomTextStyle.appbarSecondTitleStyle),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
