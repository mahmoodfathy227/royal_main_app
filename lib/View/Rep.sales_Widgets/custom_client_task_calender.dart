import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';

import '../../contants.dart';

class CustomClientTaskCalender extends StatefulWidget {

  bool track;
  CustomClientTaskCalender({
    required this.track,
  });

  @override
  State<CustomClientTaskCalender> createState() => _CustomClientTaskCalenderState();
}

class _CustomClientTaskCalenderState extends State<CustomClientTaskCalender> {
  late final tasks;


  @override
void initState() {
//tasks = context.read<TaskOutputs>().getTasks();
// filterTasksByDay();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              "11:35",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "13:05",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(width: 25.w,),
        Expanded(
          child: SizedBox(
            width: SizeConfig.screenWidth / 1.3,
            height: SizeConfig.screenHeight / 6.5,
            child: Card(
              color: const Color(0xffF6F6F6),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xffF6F6F6),
                              radius: 23.r,
                              child:
                              Image.asset("assets/images/Person_image.png", fit: BoxFit.cover,),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ahmed Hossam",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Sales Rep.",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearPercentIndicator(
                            width: 160.w,
                            lineHeight: 6.h,
                            percent: 1.0,
                            backgroundColor: Colors.grey[200],
                            progressColor: (widget.track) ? AppColors().OntrackColor : AppColors().OfftrackColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (widget.track) ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                    border: Border.all(
                                        color: Colors.white, width: 1.w)),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                (widget.track) ? "On Track" : "Off Track",
                                style: TextStyle(
                                    color: (widget.track) ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            (widget.track) ? "5/5" : "4/5",
                            style: TextStyle(
                                color: (widget.track) ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "8.H",
                            style: TextStyle(
                                color: (widget.track) ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
