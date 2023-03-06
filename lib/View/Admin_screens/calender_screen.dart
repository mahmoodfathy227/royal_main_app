import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/View/Accountant_Screens/chat_screen.dart';
import 'package:royal_marketing/contants.dart';

import '../../Controller/task_outputs.dart';
import '../Rep.sales_Screens/view_task_collection.dart';
import '../Widgets/custom_pipe_line_calender.dart';
import '../Widgets/image_profile_and_notification.dart';
import '../Widgets/week_bar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late final tasks;
  String customDate = "Pick a date";

  @override
  void initState() {
    tasks = Provider.of<TaskOutputs>(context, listen: false).getTasks();
    
// filterTasksByDay();
    super.initState();
  }

  DateTime? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors().defaultColor,
          centerTitle: true,
          toolbarHeight: 60.h,
          title: Text(
            "Calender",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/Setting_icon.svg",
              width: 25.w,
            ),
          ),
          actions: ImageProfileAndNotification()
              .imageProfileAndNotificationWithPoint(context),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 65.h,
                      left: 0.w,
                      right: 0.w,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        child: Container(
                          height: 130.h,
                          width: double.infinity,
                          color: AppColors().defaultColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                            child: DatePicker(
                              Provider.of<TaskOutputs>(context , listen: true).customDate,
                              // DateTime.parse("2022-06-06"),
                              initialSelectedDate: DateTime.now(),
                              width: 45.w,
                              selectionColor: Colors.white,
                              selectedTextColor: AppColors().defaultColor,
                              dateTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              monthTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              dayTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              onDateChange: (date) async{

                                // New date selected
                                setState(() {
                                  _selectedValue = date;

                                });
                                String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedValue!);
                                String replaced = formattedDate.replaceAll('-', '/');
                                print(replaced);
                                setState(() {
                                  customDate = replaced;
                                });
                                Provider.of<TaskOutputs>(context , listen: false).clearTheList();
                                Provider.of<TaskOutputs>(context , listen: false).filterTasksByDay(replaced);


                              },
                            ),
                          ),
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

              Provider.of<TaskOutputs>(context , listen: true).isFilteredTasksLoading ?
              Center(child: CircularProgressIndicator(),) :
              Provider.of<TaskOutputs>(context , listen: true).filteredTasks.isEmpty ?
              Center(child: Text("No Tasks in this Date"),) :
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Container(
                    width: 350.w,
                    height: 350.h,
                    child: ListView.separated(
                      // shrinkWrap: true,
                        itemBuilder: (context, index) =>   taskDetails(index:index ),
                        separatorBuilder: (context, index) => SizedBox(height: 5,),
                        itemCount: Provider.of<TaskOutputs>(context , listen: true).customDatepepeLineNames.length
                    ),
                  ),
                  ),
              )
            ]
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 5.w, right: 8.w),
              //   child: SizedBox(
              //     height: 235.h,
              //     child: ListView.builder(
              //       itemCount: 2,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Padding(
              //           padding: EdgeInsets.symmetric(vertical: 5.h),
              //           child: Text("gfgdf")
              //           // CustomPipeLineCalender(track: true,),
              //         );
              //       },),
              //   ),
              // ),


          ),
        );

  }
}

class taskDetails extends StatelessWidget {
  final int index;
  const taskDetails({
    Key? key, required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {


              return ViewTaskCollection(
                  pipeLineName: Provider.of<TaskOutputs>(context , listen: false).customDatepepeLineNames[index]
              );
            }));
        onLongPress: () {
        };

      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                // Text(
                //   Provider.of<TaskOutputs>(context , listen: true).filteredTasks[index].fromTime,
                //   // model[index].from_time,
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Text(
                //   Provider.of<TaskOutputs>(context , listen: true).filteredTasks[index].toTime,
                //   // model[index].to_time,
                //   style: TextStyle(
                //     color: Colors.grey[400],
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),
            SizedBox(width: 15.w,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {


                      return ViewTaskCollection(
                          pipeLineName: Provider.of<TaskOutputs>(context , listen: false).customDatepepeLineNames[index]
                      );
                    }));
                onLongPress: () {
                };
              },
              child: SizedBox(
                width: SizeConfig.screenWidth / 1.2,
                height: SizeConfig.screenHeight / 4.5,
                child: Card(
                  color: const Color(0xffF6F6F6),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
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
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              Provider.of<TaskOutputs>(context , listen: true).customDatepepeLineNames[index],
                                              // model[index].client_name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text("Sales Rep" , style: TextStyle(color: Colors.grey[400] , fontSize: 15.sp),)
                                          ],
                                        ),
SizedBox(width: 10.w,),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 15.w , top: 20.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 8.w,
                                                    height: 8.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: true ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                                        border: Border.all(
                                                            color: Colors.white, width: 1.w)),
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Text(
                                                    true ? "On Track" : "Off Track",
                                                    style: TextStyle(
                                                        color: true ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                true ? "${Provider.of<TaskOutputs>(context , listen: true).customDatePipeLineCount[index]}/${Provider.of<TaskOutputs>(context , listen: true).customDatePipeLineCount[index]}" : "Off Track",
                                                style: TextStyle(
                                                    color: true ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                true ? "8.h" : "Off Track",
                                                style: TextStyle(
                                                    color: true ? AppColors().OntrackColor : AppColors().OfftrackColor,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // Text(
                                        //   "Sales Rep.",
                                        //   style: TextStyle(
                                        //     color: Colors.grey[600],
                                        //     fontSize: 15.sp,
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        // ),
                                        SizedBox(width: 25,),
                                        Column(

                                          children: [



                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      LinearPercentIndicator(
                                        barRadius: Radius.circular(45),
                                        width: 120.w,
                                        lineHeight: 6.h,
                                        percent: 1.0,
                                        backgroundColor: Colors.grey[200],
                                        progressColor: true? AppColors().OntrackColor : AppColors().OfftrackColor,
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),


                                // Row(
                                //   children: [
                                //     Container(
                                //       width: 8.w,
                                //       height: 8.h,
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color:  AppColors().OfftrackColor,
                                //           border: Border.all(
                                //               color: Colors.white, width: 1.w)),
                                //     ),
                                //     SizedBox(width: 5,),
                                //     // Text(
                                //     //   "To Client : ${Provider.of<TaskOutputs>(context , listen: true).filteredTasks[index].clientName}",
                                //     //   style: TextStyle(
                                //     //       color: AppColors().OfftrackColor,
                                //     //       fontSize: 15.sp,
                                //     //       fontWeight: FontWeight.w600),
                                //     // ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 12.h,
                                // ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 8.w,
//                                     height: 8.h,
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color:  AppColors().OfftrackColor,
//                                         border: Border.all(
//                                             color: Colors.white, width: 1.w)),
//                                   ),
//                                   SizedBox(width: 5,),
// //                                   Text(
// //                                     "Client PhoneNumber : ${Provider.of<TaskOutputs>(context , listen: true).filteredTasks[index].client_phoneNumber}",
// // overflow: TextOverflow.ellipsis,
// //                                     style: TextStyle(
// //                                         color:  AppColors().OfftrackColor,
// //                                         fontSize: 14.sp,
// //                                         fontWeight: FontWeight.w600),
// //                                   ),
//                                 ],
//                               ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // CustomPipeLineCalender(track: false,),
      ),
    );
  }
}
