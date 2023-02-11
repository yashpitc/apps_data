import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:AppsData/app/utils/constants/icons.dart';
import 'package:AppsData/app/utils/constants/strings.dart';
import 'package:AppsData/app/routes/app_pages.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
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
            return Column(
            children: [
              Divider(
                color: AppColors.blackColor,
                thickness: 0.2,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL CHALLANAGES", style: CustomTextStyle.ChtitleStyle),
                  Text(controller.questionList.length.toString(), style: CustomTextStyle.ChCountStyle),
                ],
              ),
              SizedBox(height: 22),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("COMPLETED CHALLENGES", style: CustomTextStyle.ChtitleStyle),
                Text("0", style: CustomTextStyle.ChCountStyle),
              ]),
              SizedBox(height: 22),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("LOST CHALLENGES", style: CustomTextStyle.ChtitleStyle),
                Text("0", style: CustomTextStyle.ChCountStyle)
              ]),
              SizedBox(height: 40),
              ChallengeCardView(controller: controller),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRoundButton(
                    icon: AppIcons.continueIcon,
                    onTap: () {
                      Get.toNamed(Routes.DAILYCHALLENGEVIEW,arguments: controller);
                    },
                  ),
                  CustomRoundButton(
                    icon: AppIcons.refreshIcon,
                    onTap: () {
                      showSnackBar("Under Working...",context);
                     // controller.getNextQuestions(controller.questionList[0]);
                    },
                  ),
                  CustomRoundButton(
                    icon: AppIcons.historyIcon,
                    onTap: () {
                      Get.toNamed(Routes.PREVIOUSCHALLENGEVIEW);
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
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
