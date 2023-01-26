import 'package:AppsData/app/constants/colors.dart';
import 'package:AppsData/app/constants/images.dart';
import 'package:AppsData/app/constants/strings.dart';
import 'package:AppsData/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom/custom_textstyle.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.appbgColor,
          body: Center(child: buildImageLogo(context)),
        );
      },
    );
  }

  buildTextLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 0.2,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.firstTitleColor,
                width: 3.0,
              ),
            ),
          ),
          child: Text(AppStrings.APPFirstTitle,
              style: CustomTextStyle.firstTitleStyle),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 0.2,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.secondTitleColor,
                width: 3.0,
              ),
            ),
          ),
          child: Text(AppStrings.APPLastTitle,
              style: CustomTextStyle.secondTitleStyle),
        ),
      ],
    );
  }

  buildImageLogo(BuildContext context) {
    return Image.asset(AppImages.applogoPNG,
    width: MediaQuery.of(context).size.width / 1.4);
  }
}
