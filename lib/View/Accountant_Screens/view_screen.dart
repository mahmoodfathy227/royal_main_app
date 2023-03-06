import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';

import '../../contants.dart';

class ViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().defaultColor,
      body: SafeArea(
        child: Column(
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
                  SizedBox(width: 140.w,),
                  Text(
                    "View",
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
                            padding: EdgeInsets.symmetric(vertical: 25.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 65.w,
                                  height: 65.h,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
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
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Sales Rep.",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SvgPicture.asset("assets/icons/Coins_icon.svg", width: 35.w,),
                                const SizedBox(width: 10,),
                                Text(
                                  "20000 \$",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),





                          //FirstBloc
                          ClipRRect(
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
                          SizedBox(height: 15.h,),
                          //SecondBloc
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: Container(
                              width: double.infinity,
                              height: 100.h,
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              color: Colors.grey[200],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Reason of Visit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.white,
                                      border: Border.all(color: Colors.black, width: 5.w, style: BorderStyle.solid),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      size: 20.w,
                                      color: AppColors().defaultColor,
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    "Collect",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.w,
                                        fontWeight: FontWeight.w700),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          descriptionTextFormField(),
                          SizedBox(height: 15.h,),
                          fileAttachment(),
                          SizedBox(height: 30.h,),
                          Center(
                            child: CustomButton(
                              text: "Withdraw",
                              onPressed: (){

                              },
                            ),
                          ),
                          SizedBox(height: 25.h,),
                          Center(
                            child: SizedBox(
                              width: 400.w,
                              height: 80.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffF5F7FE),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25))),
                                ),
                                onPressed: () {

                                },
                                child: Text(
                                    "Report",
                                    style: TextStyle(
                                      color: AppColors().defaultColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
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
        hintText: "Description",
        hintStyle: TextStyle(
          color: Colors.black,
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

  Widget fileAttachment(){
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: double.infinity,
        height: 350.h,
        color: Colors.grey[200],
        padding: EdgeInsets.all(25.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "File Attachment",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w400),
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
                          fontSize: 20.sp,
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
                  icon: SvgPicture.asset("assets/icons/Download_icon.svg", width: 35.w,),
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
                          fontSize: 22.sp,
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
                  icon: SvgPicture.asset("assets/icons/Download_icon.svg", width: 35.w,),
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
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "12 MB",
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
                  icon: SvgPicture.asset("assets/icons/Download_icon.svg", width: 35.w,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

