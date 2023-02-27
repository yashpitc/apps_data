import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/components/widgets/custom_card_view.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:AppsData/app/utils/constants/strings.dart';
import 'package:AppsData/app/modules/daily_challenge/controllers/daily_challenge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../components/widgets/challange_card_view.dart';
import '../../../components/widgets/custom_button.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class DailyChallengeView extends StatelessWidget {
  DailyChallengeView({Key? key}) : super(key: key);
  DashboardController dsController = Get.arguments;
  final dbController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dbController.getChallengeCount();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.dashboardBGColor,
        appBar: CustomAppBar(
          firstTitle: AppStrings.YOURDAILY,
          secondTitle: AppStrings.APPLastTitle,
          backbutton: false,
          firstTitleColor: AppColors.blackColor,
          secondTitleColor: AppColors.whiteColor,
          notiButton: false,
        ),
        body: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: GetBuilder<DailyChallengeController>(
                  init: DailyChallengeController(),
                  builder: (controller) {
                      return Obx(()=>
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(
                              color: AppColors.blackColor,
                              thickness: 0.2,
                            ),
                            SizedBox(height: 20),
                            ChallengeCardView(controller: dsController),
                            SizedBox(height: 40),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(AppStrings.TIMELEFTTEXT,
                                style: CustomTextStyle.timeLeftStyle,
                              ),
                            ),
                            SizedBox(height: 25),
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width / 1.3,
                              animation: true,
                              lineHeight: 16.0,
                              animationDuration: 2500,
                              percent: controller.challengeLeftPercentage.value,
                              barRadius: Radius.circular(28.0),
                              backgroundColor: AppColors.whiteColor,
                              alignment:  MainAxisAlignment.center,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: AppColors.cardBorderColor,
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.challengeLeftTime.value,
                                      style: CustomTextStyle.timeStampStyle),
                                  Text("24:00",
                                      style: CustomTextStyle.timeStampStyle),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            CustomButton(
                              contentPadding: const EdgeInsets.only(top: 15.0,bottom:15.0 ),
                              buttonText: "COMPLETE CHALLENGE",
                              onTap: () {
                                controller.updateCompletedChallenge(
                                    dsController.userQuestionList.length == 1?
                                    dsController.userQuestionList[0]:
                                dsController.userQuestionList.value[dsController.questionValue.value]);
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                  }
                ),
              )
             ),
    );
          }
  }


