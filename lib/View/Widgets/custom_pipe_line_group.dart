import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/Model/test_task_model.dart';

import '../../Model/task_model.dart';
import '../../contants.dart';

class CustomPipeLineGroup extends StatefulWidget {



  final String pipeLineName;
  final String tasksNumber;
final  int doneTasks;


  CustomPipeLineGroup(  {Key? key, required this.pipeLineName, required this.tasksNumber, required this.doneTasks, }) : super(key: key);

  @override
  State<CustomPipeLineGroup> createState() => _CustomPipeLineListItemState();
}

class _CustomPipeLineListItemState extends State<CustomPipeLineGroup> {


  bool taskSelected = false;

  @override
void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      
      child: Container(
        width: double.infinity,
        height: 270.h,
        margin: EdgeInsets.all(25.0),
        decoration: BoxDecoration(

          color: Colors.grey[200],
          border: Border.all(color: Colors.green , width: 3.0 ,),
          borderRadius: BorderRadius.circular(45)

        ),
        
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(

              child: Row(
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
                  SizedBox(width: 35.w,),
                  Container(
                    width: 150,
                    child: Text(
                      "${widget.pipeLineName}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors().OntrackColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),


                  // SvgPicture.asset("assets/icons/Delete_icon.svg", width: 25.w,),


                ],
              ),
            ),
            SizedBox(height: 40.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/note_icon.svg", width: 20.w, color: AppColors().defaultColor,),
                    SizedBox(width: 5,),
                    Container(
                      width: 200.w,

                      child: Text(
                        "Name : ${widget.pipeLineName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors().defaultColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 15.h,),

            Row(
              children: [
                SvgPicture.asset("assets/icons/Calendar_icon.svg", width: 20.w, color: AppColors().defaultColor,),
                SizedBox(width: 5,),
                Text(
                  "Number Of Tasks : ${widget.tasksNumber}",
                  style: TextStyle(
                    color: AppColors().defaultColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h,),

            Row(
              children: [
                SvgPicture.asset("assets/icons/Clock_icon.svg", width: 20.w, color: AppColors().defaultColor,),
                SizedBox(width: 5,),

                Text(
                  "Done Tasks : ${widget.doneTasks}",
                  style: TextStyle(
                    color: AppColors().defaultColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
