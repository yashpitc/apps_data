import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ChallengeCardView extends StatelessWidget {
  const ChallengeCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return simpleCardView(context);
  }

  simpleCardView(BuildContext context) {
    return Container(
      height: 328,
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
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(24.0),bottomRight: Radius.circular(24.0))
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
            height: 300,
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
            padding: EdgeInsets.only(left: 40,right: 40,top: 15,bottom: 10),
            child: Center(
              child: Text(
                "Watch a relaxing movie, immerse yourself completely in the experience.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cardBorderColor
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
