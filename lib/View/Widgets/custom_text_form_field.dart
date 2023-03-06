import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomTextFormField extends StatelessWidget {
  final String? text;
  final String? hint;
  final String? icon;
  final Color? iconColor;
  final fontFamily;
  final double fontSize;
  var onSave;
  var validator;
  var keyboardType;

  CustomTextFormField({Key? key,
    this.text,
    this.hint,
    this.fontFamily = "SF Pro Display",
    this.fontSize= 14,
    this.onSave,
    this.validator,
    this.keyboardType,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            onSaved: onSave,
            validator: validator,
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black45,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SvgPicture.asset(icon!, color: iconColor ,width: 22.w),
              ),
              contentPadding: EdgeInsets.all(18.r),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}