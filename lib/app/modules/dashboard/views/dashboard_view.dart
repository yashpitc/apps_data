import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:AppsData/app/utils/constants/icons.dart';
import 'package:AppsData/app/utils/constants/strings.dart';
import 'package:AppsData/app/routes/app_pages.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../components/widgets/challange_card_view.dart';
import '../../../components/widgets/custom_round_button.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBGColor,
      appBar: CustomAppBar(
        firstTitle: AppStrings.APPFirstTitle,
        secondTitle: AppStrings.APPLastTitle,
        firstTitleColor: AppColors.blackColor,
        secondTitleColor: AppColors.whiteColor,
        backbutton: false,
        notiButton: true,
        notiOnTap: () {
          Get.toNamed(Routes.NOTIFICATIONVIEW);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: GetBuilder<DashboardController>(
        init: DashboardController(),
          builder: (controller){
            return Obx(() =>
                Column(
              children: [
                Divider(
                  color: AppColors.blackColor,
                  thickness: 0.2,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("TOTAL CHALLANAGES", style: CustomTextStyle.ChtitleStyle),
                    Spacer(),
                    Text(controller.totalChallengeCount.value.toString(), style: CustomTextStyle.ChCountStyle),
                    SizedBox(width: 5)
                  ],
                ),
                SizedBox(height: 22),
                Row(children: [
                  Text("COMPLETED CHALLENGES", style: CustomTextStyle.ChtitleStyle),
                  Spacer(),
                  Text(controller.completeChallengeCount.value.toString(), style: CustomTextStyle.ChCountStyle),
                  SizedBox(width: 5)
                ]),
                SizedBox(height: 22),
                Row( children: [
                  Text("LOST CHALLENGES", style: CustomTextStyle.ChtitleStyle),
                  Spacer(),
                  Text(controller.lostChallengeCount.value.toString(), style: CustomTextStyle.ChCountStyle),
                  SizedBox(width: 5)
                ]),
                SizedBox(height: 25),
                InkWell(
                  splashFactory:  NoSplash.splashFactory,
                  onTap: () {
                    Get.toNamed(Routes.PREVIOUSCHALLENGEVIEW);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Row(
                        children: [
                      Text("CHALLENGE HISTORY", style: CustomTextStyle.ChtitleStyle),
                      Spacer(),
                      Container(
                          height:30,
                          width: 30,
                          child: SvgPicture.asset(AppIcons.historyIcon)),
                    ]),
                  ),
                ),
                const SizedBox(height: 40),
                ChallengeCardView(controller: controller),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomRoundButton(
                      icon: AppIcons.continueIcon,
                      onTap: () {
                        if (controller.userQuestionList.isEmpty) {
                          showSnackBar(
                              "Your Today's Challenge Completed, Come back Tomorrow.",
                              context);
                        } else {
                          controller.addCurrentChallenge(
                              controller.userQuestionList.length == 1 ?
                              controller.userQuestionList[0] :
                              controller.userQuestionList[controller
                                  .questionValue.value]);
                          Get.offAndToNamed(
                              Routes.DAILYCHALLENGEVIEW, arguments: controller);
                        }
                      }
                    ),
                    CustomRoundButton(
                      icon: AppIcons.refreshIcon,
                      onTap: () {
                        controller.getNextQuestions();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
          ),
            );
        }
      ),
    ));
  }

  showSnackBar(String text,BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(color: AppColors.blackColor)),
        backgroundColor: AppColors.whiteColor,
      ),
    );
  }
}
