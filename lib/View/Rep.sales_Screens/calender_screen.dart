import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/view_task_screen.dart';
import 'package:royal_marketing/contants.dart';

import '../../Controller/task_outputs.dart';
import '../Accountant_Screens/chat_screen.dart';
import '../Rep.sales_Widgets/custom_client_task_calender.dart';
import '../Widgets/week_bar.dart';

class CalenderRepScreen extends StatefulWidget {
  const CalenderRepScreen({Key? key}) : super(key: key);

  @override
  State<CalenderRepScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderRepScreen> {
  String customDate = "Pick a date";

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
          icon: SvgPicture.asset("assets/icons/Setting_icon.svg",width: 25.w,),
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
      body: SingleChildScrollView(
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
                              Provider.of<TaskOutputs>(context , listen: false).filterRepTasksByDay(replaced);


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
            Provider.of<TaskOutputs>(context , listen: true).isFilteredRepTasksLoading ?
            Center(child: CircularProgressIndicator(),) :
            Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks.isEmpty ?
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
                      itemCount: Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks.length
                  ),
                ),
              ),
            )
          ],
        ),
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

          );
        }));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks[index].fromTime,
                  // model[index].from_time,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks[index].toTime,
                  // model[index].to_time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(width: 15.w,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return  ViewTaskScreen(
                    locationName: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].locationName ,
                    clientName: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].clientName,
                    descripttion: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].description,
                    durationTo: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].toDate,
                    phoneNumber:  Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].client_phoneNumber,
                    TimeTo: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].toTime,
                    lat: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].latitude ,
                    long: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].longitude ,
reasonOfVisit: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].reason_of_visit,
                    repSalesDescription: Provider.of<TaskOutputs>(context , listen: false).filteredRepTasks[index].rep_sales_descroption,
                  );
                }));
              },
              child: SizedBox(
                width: SizeConfig.screenWidth / 1.4,
                height: SizeConfig.screenHeight / 3.5,
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
                                    Text(
                                      Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks[index].assignToName,
                                      // model[index].client_name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Sales Rep.",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 25,),
                                        Column(

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
                                  child: LinearPercentIndicator(
                                    width: 120.w,
                                    lineHeight: 6.h,
                                    percent: 1.0,
                                    backgroundColor: Colors.grey[200],
                                    progressColor: true? AppColors().OntrackColor : AppColors().OfftrackColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 8.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:  AppColors().OfftrackColor,
                                          border: Border.all(
                                              color: Colors.white, width: 1.w)),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "To Client : ${Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks[index].clientName}",
                                      style: TextStyle(
                                          color: AppColors().OfftrackColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 8.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:  AppColors().OfftrackColor,
                                          border: Border.all(
                                              color: Colors.white, width: 1.w)),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Client PhoneNumber : ${Provider.of<TaskOutputs>(context , listen: true).filteredRepTasks[index].client_phoneNumber}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color:  AppColors().OfftrackColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
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
