import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/contants.dart';

class CustomGroupChatListItem extends StatefulWidget {
  int index;
  var data;
  int TeamNumber;


  CustomGroupChatListItem(this.index, this.data, this.TeamNumber);

  @override
  State<CustomGroupChatListItem> createState() => _CustomGroupChatListItemState();
}

class _CustomGroupChatListItemState extends State<CustomGroupChatListItem> {
  @override
  Widget build(BuildContext context) {
    print("this is data ${widget.data[widget.index].team_number}");

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 45.w,
          height: 45.h,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Image.asset("assets/images/Group_image.png", fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 10.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RichText(
            //   text: TextSpan(
            //     text: Provider.of<TeamOutputs>(context , listen: true).teamsList[widget.index].team_name,//"A1 Team",
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 18.sp,
            //         fontWeight: FontWeight.bold),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: " (${Provider.of<TeamOutputs>(context , listen: true).teamsList[widget.index].team_number} Members)",
            //         style: TextStyle(
            //           color: AppColors().defaultColor,
            //           fontSize: 13.sp,
            //           fontWeight: FontWeight.bold,
            //         )
            //       ),
            //     ],
            //   ),
            // ),
            Text(
              "Ahmed Hossam Sent ....",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "Today,12:30pm",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
