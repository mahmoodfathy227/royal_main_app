import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:royal_marketing/Model/test_task_model.dart';

import '../../Model/task_model.dart';
import '../../contants.dart';





getDay(date){
  return DateFormat('EEEE').format(date); /// e.g Thursday

}
class CustomPipeLineListItem extends StatefulWidget {
  bool enableCheckBox;
  int index;
  // var userData;
  List <TestTaskModel> taskData;

  CustomPipeLineListItem(this.enableCheckBox, this.index, this.taskData, {Key? key}) : super(key: key);

  @override
  State<CustomPipeLineListItem> createState() => _CustomPipeLineListItemState();
}

class _CustomPipeLineListItemState extends State<CustomPipeLineListItem> {


  bool taskSelected = false;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: double.infinity,
        height: 490.h,
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // (widget.enableCheckBox)? Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Transform.scale(
            //       scale: 1.3.r,
            //       child: Checkbox(
            //         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            //         checkColor: Colors.white,
            //         activeColor: AppColors().defaultColor,
            //         value: taskSelected,
            //         onChanged: (value) {
            //           setState(() {
            //             taskSelected = value!;
            //           });
            //           },
            //       ),
            //     ),
            //   ],
            // ):Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                    child: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 6.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Client Name : ${widget.taskData[widget.index].clientName}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  ],
                ),
                const Spacer(),
                // SvgPicture.asset("assets/icons/Delete_icon.svg", width: 25.w,),
                 SvgPicture.asset("assets/icons/note_icon.svg", width: 17.w, color: AppColors().defaultColor,),

              ],
            ),
            SizedBox(height: 15.h,),

            SizedBox(height: 10.h,),
            Text(
              "Assigned To ${widget.taskData[widget.index].assignToName}",
              style: TextStyle(
                color: AppColors().defaultColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5.h,),

            SizedBox(height: 5.h,),

            SizedBox(height: 5.h,),

            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Duration From",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15.w,),
                Text(
                  "Duration To",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/Date_icon.svg", width: 30.w,),
                SizedBox(width: 10.w,),
                Text(
                  widget.taskData[widget.index].fromDate,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 15.w,),
                SvgPicture.asset("assets/icons/Date_icon.svg", width: 30.w,),
                SizedBox(width: 10.w,),
                Text(

                  widget.taskData[widget.index].fromDate,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/Date_icon.svg", width: 30.w,),
                SizedBox(width: 10.w,),
                Text(
                  getDay(widget.taskData[widget.index].fromDate),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 15.w,),
                SvgPicture.asset("assets/icons/Date_icon.svg", width: 30.w,),
                SizedBox(width: 10.w,),
                Text(

                  widget.taskData[widget.index].fromDate,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                ),
                SizedBox(width: 12.w,),
                Text(
                  widget.taskData[widget.index].fromTime,

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 25.w,),
                SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                SizedBox(width: 12.w,),
                Text(
                  widget.taskData[widget.index].toTime,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            Text(
              "Description:",
              style: TextStyle(
                color: AppColors().defaultColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,

              ),
            ),
            SizedBox(height: 10.h,),
            Text(
              widget.taskData[widget.index].description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
