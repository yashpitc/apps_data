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
        required this.firstTitleColor,
        required this.secondTitleColor,
        required this.notiButton,
        required this.backbutton,
        this.notiOnTap});

  String? firstTitle;
  String? secondTitle;
  Color? firstTitleColor;
  Color? secondTitleColor;
  bool? backbutton;
  bool? notiButton;
  List<Widget>? actions;
  GestureTapCallback? notiOnTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
      leadingWidth: backbutton!? 20.0 : 15.0,
      title:  buildTextTitle(firstTitle!, secondTitle!,firstTitleColor!,secondTitleColor!),
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

  buildTextTitle(
      String firstTitle,
      String secondTitle,
      Color firstTitleColor,
      Color secondTitleColor) {
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
                color: firstTitleColor,
                width: 1.8,
              ),
            ),
          ),
          child: Text(firstTitle, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: firstTitleColor,
          )),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 0.0,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: secondTitleColor,
                width: 1.8,
              ),
            ),
          ),
          child:
          Text(secondTitle, style:TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: secondTitleColor,
          )),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
