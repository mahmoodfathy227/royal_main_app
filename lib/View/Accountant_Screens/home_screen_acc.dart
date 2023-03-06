import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:royal_marketing/View/Accountant_Screens/view_screen.dart';

import '../../contants.dart';
import '../Screens/pre_signin_screen.dart';
import '../Widgets/week_bar.dart';

class HomeScreenAcc extends StatelessWidget {
  const HomeScreenAcc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors().defaultColor,
        centerTitle: true,
        toolbarHeight: 60.h,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> PreloginScreen()), (route) => false);

          },
          icon: SvgPicture.asset("assets/icons/logout_icon.svg",width: 25.w,),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: SvgPicture.asset("assets/icons/Notification_icon.svg", width: 25.w,),
          ),
        ],
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 40.h,
                  left: 0.w,
                  right: 0.w,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    child: Container(
                      height: 120.h,
                      width: double.infinity,
                      color: AppColors().defaultColor,
                      child: statsBar(),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.h,
                  left: 0.w,
                  right: 0.w,
                  child: const WeekBar(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.r, right: 5.r,top: 15.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Waiting to withdraw",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                          return ViewScreen();
                                        }));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 100.h,
                                        color: Colors.grey[200],
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 25.r,
                                              backgroundColor: Colors.grey[200],
                                              child: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover,),
                                            ),
                                            SizedBox(width: 8.w,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ahmed Hossam",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                Text(
                                                  "Sales Rep.",
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SvgPicture.asset("assets/icons/Coins_icon.svg", width: 30.w,),
                                            SizedBox(width: 10.w,),
                                            Text(
                                              "10000 \$",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 28.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("1.8K",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Agent",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14.sp,
                  ),),
              ],
            ),
          ),
        ),
        VerticalDivider(
          color: Colors.black,
          thickness: 1.w,
          indent: 55.h,
          endIndent: 20.h,
          width: 2.w,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 55.h),
            child: Column(
              children: [
                Text("132",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("sales rep.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14.sp,
                  ),),
              ],
            ),
          ),
        ),
        VerticalDivider(
          color: Colors.black,
          thickness: 1.w,
          indent: 55.h,
          endIndent: 20.h,
          width: 2.w,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 55.h),
            child: Column(
              children: [
                Text("5K",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Ongoing Deal",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14.sp,
                  ),),
              ],
            ),
          ),
        ),
        VerticalDivider(
          color: Colors.black,
          thickness: 1.w,
          indent: 55.h,
          endIndent: 20.h,
          width: 2.w,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 55.h),
            child: Column(
              children: [
                Text("36",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Paused Deal",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14.sp,
                  ),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
