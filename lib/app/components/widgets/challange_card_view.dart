import 'package:AppsData/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ChallengeCardView extends StatelessWidget {
   ChallengeCardView({Key? key,this.controller}) : super(key: key);
    DashboardController? controller;

  @override
  Widget build(BuildContext context) {
    return simpleCardView(context, controller!);
  }

  simpleCardView(BuildContext context,DashboardController controller) {
    var dHeight = MediaQuery.of(context).size.height;
    return Container(
      height: dHeight > 800 ? 400 : 328,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: 18.0,
            right: 18.0,
            bottom: 6.0,
            child: Container(
              height: 20,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.4,
              decoration: BoxDecoration(
                  color: AppColors.appbgColor,
                  borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(24.0),bottomRight: Radius.circular(24.0))
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            right: 10.0,
            bottom: 15.0,
            child: Container(
              height: 20,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.4,
              decoration: BoxDecoration(
                color: AppColors.cardBg2Color,
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(24.0),bottomRight: Radius.circular(24.0)),
              ),
            ),
          ),
          Container(
            height: dHeight > 800 ? 375 : 300,
            width: MediaQuery
                .of(context)
                .size
                .width / 1.4,
            decoration: BoxDecoration(
              color: AppColors.cardBgColor,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                  width: 4,
                  color: AppColors.cardBorderColor
              ),
            ),
            padding: const EdgeInsets.only(left: 40,right: 40,top: 15,bottom: 10),
            child: Center(
              child: controller.isLoading.value?
                 CircularProgressIndicator(color: AppColors.cardBorderColor):
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Html(
                      data: controller.questionList[0].toString(),
                        style: {
                        "p": Style(
                              fontSize: FontSize(24.0),
                          fontWeight: FontWeight.w600,
                           alignment: Alignment.center,
                            color: AppColors.cardBorderColor
                        ),
                        },
                    ),
                  ],
                ),
          ),
          ),
        ],
      ),
    );
  }
}
