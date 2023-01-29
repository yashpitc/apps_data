import 'package:AppsData/app/components/custom/custom_appbar.dart';
import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:AppsData/app/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBGColor,
      appBar: CustomAppBar(
        firstTitle: AppStrings.YOUR,
        secondTitle: AppStrings.NOTIFICATION,
        firstTitleColor: AppColors.whiteColor,
        secondTitleColor: AppColors.blackColor,
        backbutton: true,
        notiButton: false,
      ),
      body: GetBuilder<NotificationController>(
          init: NotificationController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: AppColors.blackColor,
                    thickness: 0.2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "LAST 30 DAYS",
                    style: CustomTextStyle.historyTitleStyle,
                  ),
                  ListView.builder(
                      itemCount: controller.notificationList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return notificationCardView(
                            context, controller.notificationList[index]);
                      }),
                ],
              ),
            );
          }),
    );
  }

  notificationCardView(BuildContext context, String data) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 1.1,
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 12.0, left: 12.0, right: 12.0, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text("\"$data\"",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.notiCardTextStyle),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("1 week ago",
                    style: CustomTextStyle.notiCardTimeStyle),
              )
            ],
          ),
        ),
      ),
    );
  }
}
