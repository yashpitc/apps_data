import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/constants/colors.dart';
import 'package:AppsData/app/constants/icons.dart';
import 'package:AppsData/app/constants/strings.dart';
import 'package:AppsData/app/routes/app_pages.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/widgets/challange_card_view.dart';
import '../../../components/widgets/custom_round_button.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
        child: Column(
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
                Text("60", style: CustomTextStyle.ChCountStyle),
              ],
            ),
            SizedBox(height: 22),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("COMPLETED CHALLENGES", style: CustomTextStyle.ChtitleStyle),
              Text("23", style: CustomTextStyle.ChCountStyle),
            ]),
            SizedBox(height: 22),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("LOST CHALLENGES", style: CustomTextStyle.ChtitleStyle),
              Text("03", style: CustomTextStyle.ChCountStyle)
            ]),
            SizedBox(height: 40),
            ChallengeCardView(),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomRoundButton(
                  icon: AppIcons.continueIcon,
                  onTap: () {
                    Get.toNamed(Routes.DAILYCHALLENGEVIEW);
                  },
                ),
                CustomRoundButton(
                  icon: AppIcons.refreshIcon,
                  onTap: () {},
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
        ),
      ),
    );
  }
}
