import 'package:AppsData/app/components/custom/custom_textstyle.dart';
import 'package:AppsData/app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../data/models/PreviousChallengeModel.dart';

class CustomCardView extends StatelessWidget {
 CustomCardView({Key? key,required this.data,this.index}) : super(key: key);
  PreviousChallengeModel data;
  int? index;
  List colors = [AppColors.pinkColor, AppColors.blueColor,AppColors.blackColor];

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
                child: Html(
                  data: data.question,
                  style: {
                    "p": Style(
                        fontSize: const FontSize(16),
                          fontWeight: FontWeight.w600,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign:  TextAlign.center,
                        color: colors[index! % colors.length],
                    ),
                  },
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.type.toString(),
                      style: CustomTextStyle.cardTimeStyle
                  ),
                  Text(convertToAgo(data.completedTime.toString()),
                      style: CustomTextStyle.cardTimeStyle
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

 String convertToAgo(String dateTime) {
   DateTime input =
   DateFormat("MMMM, dd, yyyy,hh:mm:ss a").parse(dateTime, true);
   Duration diff = DateTime.now().difference(input);

   if (diff.inDays >= 1) {
     return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
   } else if (diff.inHours >= 1) {
     return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
   } else if (diff.inMinutes >= 1) {
     return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
   } else if (diff.inSeconds >= 1) {
     return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
   } else {
     return 'just now';
   }
 }

}

