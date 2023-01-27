import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
 CustomCardView({Key? key,this.data,this.index}) : super(key: key);
  String? data;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width / 1.1,
    padding: const EdgeInsets.only(top: 15),
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
          color: AppColors.whiteColor,
        child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Text(data.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: index == 0?
                  AppColors.pinkColor :
                  index ==1?
                  AppColors.blueColor:
                  AppColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("1 week ago",
                    style: CustomTextStyle.cardTimeStyle
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

