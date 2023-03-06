import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomContactItemList extends StatelessWidget {
  const CustomContactItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 45.h,
            width: 45.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover,),
            ),
          ),
          SizedBox(width: 10.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jerome Bell",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "+20 101 672 8784",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: (){

            },
            icon: SvgPicture.asset("assets/icons/Chat_icon.svg", color: Colors.grey, width: 33.w,),
          ),
          SizedBox(width: 3.w,),
          IconButton(
              onPressed: (){

              },
              icon: SvgPicture.asset("assets/icons/Phone_icon.svg", color: Colors.grey, width: 20.w,)),
        ],
      ),
    );
  }
}
