import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/components/widgets/custom_card_view.dart';
import 'package:AppsData/app/constants/colors.dart';
import 'package:AppsData/app/constants/strings.dart';
import 'package:AppsData/app/modules/daily_challenge/controllers/daily_challenge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../components/widgets/challange_card_view.dart';
import '../../../components/widgets/custom_button.dart';

class DailyChallengeView extends StatelessWidget {
 const DailyChallengeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBGColor,
      appBar: CustomAppBar(
        firstTitle: AppStrings.YOURDAILY,
        secondTitle: AppStrings.APPLastTitle,
        backbutton: false,
        firstTitleColor: AppColors.blackColor,
        secondTitleColor: AppColors.whiteColor,
        notiButton: false,
      ),
      body: GetBuilder<DailyChallengeController>(
          init: DailyChallengeController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    color: AppColors.blackColor,
                    thickness: 0.2,
                  ),
                  SizedBox(height: 20),
                  ChallengeCardView(),
                  SizedBox(height: 40),
                  Text(AppStrings.TIMELEFTTEXT,
                    style: CustomTextStyle.timeLeftStyle,
                  ),
                  SizedBox(height: 25),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 1.3,
                    animation: true,
                    lineHeight: 16.0,
                    animationDuration: 2500,
                    percent: 0.3,
                    barRadius: Radius.circular(28.0),
                    backgroundColor: AppColors.whiteColor,
                    alignment:  MainAxisAlignment.center,
                    //center: Text("80.0%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: AppColors.cardBorderColor,
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("02:30",
                        style: CustomTextStyle.timeStampStyle),
                        Text("24:00",
                            style: CustomTextStyle.timeStampStyle),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  CustomButton(onTap: () {},buttonText: "COMPLETE CHALLENGE",),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
      ),
    );
  }

}
