import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';

import '../../contants.dart';
import '../Rep.sales_Screens/track_location.dart';
import '../Rep.sales_Screens/view_task_screen.dart';
import '../Widgets/custom_button.dart';

class CustomRepHomeListItem extends StatelessWidget {
   CustomRepHomeListItem({Key? key, required this.index}) : super(key: key);
final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return  ViewTaskScreen(
            locationName: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].locationName ,
          clientName: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].clientName,
            descripttion: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].description,
            durationTo: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].toDate,
            phoneNumber:  Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].client_phoneNumber,
            TimeTo: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].toTime,
lat: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].latitude ,
            long: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].longitude ,
            reasonOfVisit: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].reason_of_visit ,
            repSalesDescription: Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].rep_sales_descroption ,

          );
        }));
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: double.infinity,
              height: 350.h,
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [


                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.person, color: AppColors().defaultColor, size: 35.w,),
                        SizedBox(width: 10.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                          Container(

                            child: Text(
                              Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].clientName,
                              style: TextStyle(
                                color: AppColors().defaultColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            width: 150.w,
                          ),
                                SizedBox(width: 25.w,),

                              ],
                            ),
                            Text(
                              "Client",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: 55,
                          child: Padding(
                            padding: EdgeInsets.only(top: 22.h),
                            child: Text(
                              "Duration To",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w,),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: AppColors().defaultColor, size: 35.w,),
                        SizedBox(width: 11.w,),
                        Container(
                          width: 150.w,
                          child: Text(
                            Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].locationName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset("assets/icons/Date_icon.svg", width: 32.w,),
                        SizedBox(width: 10.w,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Text(
                            Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].fromDate,

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
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
                        SizedBox(width: 5.w,),
                        SvgPicture.asset("assets/icons/Phone_icon.svg", color: AppColors().defaultColor,width: 27.w,),
                        SizedBox(width: 16.w,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Text(
                            Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].client_phoneNumber,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset("assets/icons/Clock_icon.svg", width: 25.w,),
                        SizedBox(width: 12.w,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                          child: Text(
                            Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].fromTime,

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w,),

                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/note_icon.svg" , width: 30.w, color: AppColors().defaultColor,),
                          SizedBox(width: 9.w,),
                          Text(
                            Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].description,

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],

                      ),
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      children: [
                        Text("Task Done:" , style: TextStyle(fontSize: 17 , color: AppColors().defaultColor),),
                        SizedBox(width: 10.w,),
                        Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].isDone == false ?
                            Text("No" , style: TextStyle(fontSize: 14.sp , fontWeight: FontWeight.w500),) :
                            Row(children: [
                              Text("Yes" , style: TextStyle(fontSize: 14.sp , fontWeight: FontWeight.w500),) ,
                              SizedBox(width: 3,),
                              Icon(Icons.check_circle , color: Colors.green,)
                            ],)
                      ],
                    )
                  ],
                ),
              ),
            ),
            Provider.of<TaskOutputs>(context , listen: false).selectedTasks[index].isDone == false ?
         const  SizedBox() :
            const Icon(Icons.check_circle , color: Colors.green, size: 33,),

          ],
        ),
      ),
    );
  }
}
