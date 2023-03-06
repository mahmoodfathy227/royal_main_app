import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Controller/create_task_inputs.dart';
import '../../Controller/task_outputs.dart';
import '../../Model/test_task_model.dart';
import '../Rep.sales_Widgets/custom_rep_home_list_item.dart';
import '../Screens/pre_signin_screen.dart';
import '../Widgets/week_bar.dart';

class HomeScreenRep extends StatefulWidget {
  const HomeScreenRep({Key? key}) : super(key: key);

  @override
  State<HomeScreenRep> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenRep> {
  List<TestTaskModel> repSalesTask = [];
  String _currentEmail = "";
  int allRepSalesTasks = 0;
  int repSalesCompletedTasks = 0;
  String repSalesName = "";
  Future <bool> askPermission() async{
    print("waiting permission granted");
    PermissionStatus status = await Permission.location.request();
    print("status == ${status}");
    if(status.isDenied == true)
    {
      // askPermission();
      return false;
    }
    else
    {
      return  true;
    }
  }
  List<_ChartData> getChartData() {

    final List<_ChartData> chartData = <_ChartData>[
      _ChartData('High', 8700, const Color.fromRGBO(229, 29, 41, 1)),
    ];

    return chartData;
  }
  late List<_ChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    getCurrentEmail();

    getRepSalesName();

    askPermission();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    Provider.of<TaskOutputs>(context , listen: false).getSelectedTasks();


    super.initState();
  }


  void getCurrentEmail() async{
    final prefs = await SharedPreferences.getInstance();
    _currentEmail = prefs.getString("currentEmail")!;
  }
  void getRepSalesTasks() async{
    print("this is the name ${repSalesName}");
    await FirebaseFirestore.instance.collection("PipeLine").doc(repSalesName).collection("Tasks").get().then((value) {
      for (var doc in value.docs){
        allRepSalesTasks++;

        if(doc.data()['employee_email'] == _currentEmail && doc.data()['isDone'] == true){
          repSalesCompletedTasks++;
        }

      }
      print("all tasks == ${allRepSalesTasks}");
      setState(() {

      });
    });
  }
  Future getRepSalesName() async {
    final prefs = await SharedPreferences.getInstance();
    _currentEmail = prefs.getString("currentEmail")!;
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      for(var doc in value.docs){
        if(doc.data()['email'] == _currentEmail ){
          repSalesName = doc.data()['first_name'] +  doc.data()['last_name'];
          print(doc.data()['email']);
        }
      }
      getRepSalesTasks();
    });
    setState(() {

    });
    print("the name" + repSalesName);
  }
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
          icon: SvgPicture.asset("assets/icons/logout_icon.svg",width: 25.w, color: Colors.white,),
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
      body: RefreshIndicator(
        onRefresh: ()async{
          print("ffffffffffffff");
       return await Provider.of<TaskOutputs>(context , listen: false).getSelectedTasks();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.r, right: 5.r,top: 10.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Week Progress",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15.h,),
                                Text(
                                  "Minim dolor in amet nulla \nlaboris enim dolore consequatt.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.w,),
                          Expanded(
                            child: SizedBox(
                              height: 120.h,
                              width: 200.w,
                              child: Stack(
                                fit: StackFit.loose,
                                children: [
                                  SfCircularChart(
                                    series: <CircularSeries<_ChartData, String>>[
                                      RadialBarSeries<_ChartData, String>(
                                          dataSource: _chartData,
                                          xValueMapper: (_ChartData data, _) => data.continent,
                                          yValueMapper: (_ChartData data, _) => data.gdp,
                                          pointColorMapper: (_ChartData data, _) => data.color,
                                          cornerStyle: CornerStyle.bothCurve,
                                          radius: '85%',
                                          innerRadius: '85%',
                                          maximumValue: 10000)
                                    ],
                                  ),
                                  Positioned(
                                    top: 48.h,
                                    right: 38.w,
                                    child: Text(
                                      "99%",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //SizedBox(height: 5.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: Provider.of<TaskOutputs>(context , listen: true).selectedTasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child:  CustomRepHomeListItem(index: index),
                            );
                          },),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                Text("${allRepSalesTasks}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("All Tasks",
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
                Text("${repSalesCompletedTasks}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Completed Tasks",
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
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 55.h),
        //     child: Column(
        //       children: [
        //         Text("5K",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 20.sp,
        //           ),),
        //         Text("Ongoing Deal",
        //           style: TextStyle(
        //             color: Colors.white.withOpacity(0.5),
        //             fontSize: 14.sp,
        //           ),),
        //       ],
        //     ),
        //   ),
        // ),
        // VerticalDivider(
        //   color: Colors.black,
        //   thickness: 1.w,
        //   indent: 55.h,
        //   endIndent: 20.h,
        //   width: 2.w,
        // ),
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 55.h),
        //     child: Column(
        //       children: [
        //         Text("36",
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 20.sp,
        //           ),),
        //         Text("Paused Deal",
        //           style: TextStyle(
        //             color: Colors.white.withOpacity(0.5),
        //             fontSize: 14.sp,
        //           ),),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.continent, this.gdp, this.color);
  final String continent;
  final int gdp;
  final Color color;
}