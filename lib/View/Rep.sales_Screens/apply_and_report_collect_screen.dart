import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../contants.dart';
import '../Widgets/custom_button.dart';

class ApplyAndReportCollectScreen extends StatelessWidget {
  const ApplyAndReportCollectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().defaultColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white,),
                ),
                SizedBox(width: 40.w,),
                Text(
                  "Apply and Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                width: 80.w,
                height: 8.h,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 35.h),
                          child:  ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: Container(
                              width: double.infinity,
                              height: 200.h,
                              color: Colors.grey[200],
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 35.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.person, color: AppColors().defaultColor, size: 20.w,),
                                        SizedBox(width: 10.w,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ahmed Hossam",
                                              style: TextStyle(
                                                color: AppColors().defaultColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "Accountant",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 25.w,),
                                        Padding(
                                          padding: EdgeInsets.only(top: 22.h),
                                          child: Text(
                                            "Duration To",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_pin, color: AppColors().defaultColor, size: 20.w,),
                                        SizedBox(width: 11.w,),
                                        Text(
                                          "134, High street, \nOsman Mohamed, EG.",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(width: 30.w,),
                                        SvgPicture.asset("assets/icons/Date_icon.svg", width: 20.w,),
                                        SizedBox(width: 8.w,),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 6.h),
                                          child: Text(
                                            "23/9/2022",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 5.w,),
                                        SvgPicture.asset("assets/icons/Phone_icon.svg", color: AppColors().defaultColor,width: 15.w,),
                                        SizedBox(width: 16.w,),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5.h),
                                          child: Text(
                                            "(+XX)XXX-XXX-XXXX",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w,),
                                        SvgPicture.asset("assets/icons/Clock_icon.svg", width: 20.w,),
                                        SizedBox(width: 12.w,),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5.h),
                                          child: Text(
                                            "10:30 PM",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          child: Container(
                            width: double.infinity,
                            height: 110.h,
                            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reason of Visit",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade500, width: 5.w, style: BorderStyle.solid),
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      "Order",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Spacer(),
                                    Container(
                                      margin: const EdgeInsets.all(2),
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.white,
                                        border: Border.all(color: Colors.black, width: 5.w, style: BorderStyle.solid),
                                      ),
                                      child: Icon(
                                        Icons.circle,
                                        size: 25.w,
                                        color: AppColors().defaultColor,
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      "Collect",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h,),

                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          child: Container(
                            width: double.infinity,
                            height: 90.h,
                            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text(
                                  "Find Missing",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              const   Spacer(),
                                Container(
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white,
                                    border: Border.all(color: Colors.black, width: 5.w, style: BorderStyle.solid),
                                  ),
                                  child: Icon(
                                    Icons.circle,
                                    size: 25.w,
                                    color: AppColors().defaultColor,
                                  ),
                                ),
                              ],)



                            ],),
                          ),

                        ),
                        SizedBox(height: 15.h,),
                        amountOfMoneyTextFormField(),
                        SizedBox(height: 15.h,),
                        descriptionTextFormField(),
                        SizedBox(height: 15.h,),
                        fileAttachment(),
                        SizedBox(height: 15.h,),
                        saveLocationTextFormField(),
                        SizedBox(height: 20.h,),
                        Center(
                          child: CustomButton(
                            text: "Submit Report",
                            onPressed: (){

                            },
                          ),
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fileAttachment(){
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: double.infinity,
        height: 390.h,
        color: Colors.grey[200],
        padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 3.r, bottom: 30.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "File Attachment",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
                  onPressed: () {

                  }, icon: Icon(Icons.camera_alt_rounded, color: AppColors().defaultColor, size: 35.w,),
                ),
              ],
            ),
            SizedBox(height: 25.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/Excel_icon.svg", width: 35.w,),
                SizedBox(width: 15.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data-structures.xls",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "1.4 MB",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.clear_rounded, color: AppColors().defaultColor, size: 30.w,),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/Jpg_icon.svg", width: 35.w,),
                SizedBox(width: 15.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team-Photos.jpg",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "34 MB",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.clear_rounded, color: AppColors().defaultColor, size: 30.w,),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/Pdf_icon.svg", width: 35.w,),
                SizedBox(width: 15.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User-journey.pdf",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "12 MB",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12.h,),
                    LinearPercentIndicator(
                      width: 130.w,
                      lineHeight: 10.h,
                      percent: 0.5,
                      backgroundColor: Colors.blue.withOpacity(0.3),
                      progressColor: Colors.blue,
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppColors().defaultColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget amountOfMoneyTextFormField(){
    return TextFormField(
      //onSaved: onSave,
      //validator: validator,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: "100",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$",
            style: TextStyle(
                color: AppColors().defaultColor,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        contentPadding: EdgeInsets.all(25.r),
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
    );
  }

  Widget descriptionTextFormField(){
    return TextFormField(
      //onSaved: onSave,
      //validator: validator,
      maxLines: 5,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: "Add  Description",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 26.sp,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.all(20.r),
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
    );
  }

  Widget saveLocationTextFormField(){
    return TextFormField(
      //onSaved: onSave,
      //validator: validator,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: "Save Location",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: Icon(Icons.location_pin, color: AppColors().defaultColor, size: 35.w,),
        contentPadding: EdgeInsets.all(25.r),
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
    );
  }
}
