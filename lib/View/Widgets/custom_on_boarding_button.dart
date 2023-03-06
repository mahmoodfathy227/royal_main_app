import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_marketing/View/Screens/login_screen.dart';
import 'package:royal_marketing/contants.dart';

import '../Screens/pre_signin_screen.dart';

class CustomOnBoardingButton extends StatelessWidget {
  const CustomOnBoardingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors().defaultColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 12.h),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return PreloginScreen();
          }));
        },
        child: Text(
          "Get Start",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
