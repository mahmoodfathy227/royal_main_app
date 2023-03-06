import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../contants.dart';

class CustomButton extends StatelessWidget {

  String text;
  Function onPressed;

  CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 65.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors().defaultColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.r))),
        ),
        onPressed: () => onPressed(),
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

}
