import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDirectMessageListItem extends StatelessWidget {
  const CustomDirectMessageListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 45.w,
          height: 45.h,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 10.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jerome Bell",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Let's have a call for ....",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "Today,02:00Am",
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
