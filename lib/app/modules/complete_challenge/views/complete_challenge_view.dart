import 'package:AppsData/app/components/widgets/custom_button.dart';
import 'package:AppsData/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:AppsData/app/utils/constants/images.dart';
import 'package:AppsData/app/routes/app_pages.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';

class CompleteChallengeView extends StatelessWidget {
   CompleteChallengeView({Key? key}) : super(key: key);
   final dbController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.completeBGColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            cardView(context),
            const Spacer(),
            CustomButton(
                buttonText: "TAKE NEW CHALLENGE",
                contentPadding: const EdgeInsets.only(top: 15.0,bottom:15.0 ),
                onTap: () {
                  dbController.updateChallengeCount();
                  Get.toNamed(Routes.DASHBOARDVIEW);
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  cardView(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    return Container(
      height:dHeight > 800 ? 400 : 328,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: 18.0,
            right: 18.0,
            bottom: 6.0,
            child: Container(
              height: 20,
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                  color: AppColors.appbgColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0))),
            ),
          ),
          Positioned(
            left: 10.0,
            right: 10.0,
            bottom: 15.0,
            child: Container(
              height: 20,
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                color: AppColors.cardBg2Color,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0)),
              ),
            ),
          ),
          Container(
            height:dHeight > 800 ? 375 : 300,
            width: MediaQuery.of(context).size.width / 1.4,
            decoration: BoxDecoration(
              color: AppColors.cardBgColor,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(blurRadius: 0.5),
              ],
            ),
            padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            child: Center(child: SvgPicture.asset(AppImages.completeSVG)),
          ),
        ],
      ),
    );
  }
}
