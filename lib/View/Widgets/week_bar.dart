import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/contants.dart';

class WeekBar extends StatelessWidget {
  const WeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Container(
        height: 80.h,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  Provider.of<TaskOutputs>(context, listen: false).minusToWeek();
                },
                child: Container(
                  height: 25.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors().defaultColor,
                        width: 2.w,
                        style: BorderStyle.solid
                    ),
                  ),
                  padding: EdgeInsets.only(left: 5.w),
                  child: InkWell(
                    onTap: (){
                      Provider.of<TaskOutputs>(context, listen: false).minusToWeek();

                    },
                      child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w)),
                ),
            ),
            SizedBox(width: 12.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
                  // "Monday 24 Jan, 2022",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "This Week",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w,),
            TextButton(
              onPressed: (){
                Provider.of<TaskOutputs>(context, listen: false).addToWeek();
              },
              child: Container(
                height: 25.h,
                width: 25.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors().defaultColor,
                      width: 2.w,
                      style: BorderStyle.solid
                  ),
                ),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Provider.of<TaskOutputs>(context , listen: false).addToWeek();
                    },
                      child: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18.w)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
