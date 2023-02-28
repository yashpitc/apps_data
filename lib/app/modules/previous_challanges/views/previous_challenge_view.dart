import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:AppsData/app/utils/constants/strings.dart';
import 'package:AppsData/app/modules/previous_challanges/controllers/previous_challenge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/widgets/custom_card_view.dart';
import '../../../routes/app_pages.dart';

class PreviousChallengeView extends StatelessWidget {
  const PreviousChallengeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBGColor,
      appBar: CustomAppBar(
        firstTitle: AppStrings.YOUR,
        secondTitle: AppStrings.PREVIOUSCHALLENGE,
        firstTitleColor: AppColors.whiteColor,
        secondTitleColor: AppColors.blackColor,
        backbutton: true,
        notiButton: true,
        notiOnTap: () {
          Get.toNamed(Routes.NOTIFICATIONVIEW);
        },
      ),
      body: GetBuilder<PreviousChallengeController>(
        init: PreviousChallengeController(),
        builder: (controller){
          return  SingleChildScrollView(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0,bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  color: AppColors.blackColor,
                  thickness: 0.2,
                ),
                Obx(() =>
                    controller.isLoading.value?
                    Center(child: CircularProgressIndicator(color: AppColors.cardBorderColor)):
                    ListView.builder(
                      itemCount: controller.previousChallengeList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        return CustomCardView(data: controller.previousChallengeList[index],index: index,);
                      }),
                ),
                // CustomButton(onTap: () {},buttonText: "COMPLETE CHALLENGE",)
              ],
            ),
          );
        }
      ),
    );
  }
}
