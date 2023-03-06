import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../contants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late List<_ChartData> data;
  late TooltipBehavior _tooltipBehavior;
  String _currentEmail = "";
int allRepSalesTasks = 0;
int repSalesCompletedTasks = 0;
String repSalesName = "";
  Color monColor = AppColors().defaultColor;
  Color tueColor = AppColors().defaultColor;
  Color wedColor = AppColors().defaultColor;
  Color thuColor = AppColors().defaultColor;
  Color friColor = AppColors().defaultColor;
  Color satColor = AppColors().defaultColor;
  Color sunColor = AppColors().defaultColor;

  @override
  void initState() {
    getCurrentEmail();
    getRepSalesTasks();
    getRepSalesName();
    super.initState();
    data = [
      _ChartData('Mon', 0),
      _ChartData('Tue', 0),
      _ChartData('Wed', 0),
      _ChartData('Thu', 0),
      _ChartData('Fri', 0),
      _ChartData('Sat', 0),
      _ChartData('Sun', 0),
    ];
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      textStyle: const TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.w600),
      duration: 6000,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  const Spacer(),
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 95.w,),
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.more_vert, color: Colors.white, size: 30.w,)
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
                  height: 6.h,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            SizedBox(height: 8.h,),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: SizedBox(
                              height: 160.h,
                              width: 160.w,
                              child: DottedBorder(
                                borderType: BorderType.Circle,
                                dashPattern: const [25, 25, 25, 25],
                                strokeWidth: 3,
                                color: AppColors().defaultColor,
                                padding: const EdgeInsets.all(15),
                                child: CircleAvatar(
                                  foregroundImage:  AssetImage("assets/images/Person_image.png" , ),
                                  radius: 88.w,
                                  backgroundColor: Colors.white,

                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Center(
                          child: Text(
                            "${repSalesName}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Center(
                          child: Text(
                            "${_currentEmail}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/Coins_icon.svg", width: 30.w,),
                            SizedBox(width: 10.w,),
                            Text(
                              "0 \$",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Text(
                            "Sales Rep.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              clientsAndCompletedTasks("All Tasks" , "${allRepSalesTasks}"),
                              const Spacer(),
                              clientsAndCompletedTasks("Completed Tasks", "${repSalesCompletedTasks}"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Text(
                            "This Week Progress",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        chart(),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: Container(
                              width: double.infinity,
                              height: 75.h,
                              color: Colors.grey[200],
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/Phone_icon.svg", color: AppColors().defaultColor, width: 30.w,),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      "+201016728784",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                      ],
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

  Widget clientsAndCompletedTasks(String title, String number){
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: 155.w,
        height: 130.h,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (title == "Clients")?Icon(Icons.person, color: AppColors().defaultColor, size: 38.w,):SvgPicture.asset("assets/icons/Bar_chart_icon.svg", width: 30.w,),
                  SizedBox(width: 45.w,),
                  Text(
                    number,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  changeBarColor(int value){
    switch(value){
      case 0:
        return monColor;

      case 1:
        return tueColor;

      case 2:
        return wedColor;

      case 3:
        return thuColor;

      case 4:
        return friColor;

      case 5:
        return satColor;

      case 6:
        return sunColor;

      default:
        return AppColors().defaultColor;
    }
  }

  getBarColor(ChartPointDetails details){
    if(details.pointIndex == 0){
      setState(() {
        monColor = Colors.amber;
        tueColor = AppColors().defaultColor;
        wedColor = AppColors().defaultColor;
        thuColor = AppColors().defaultColor;
        friColor = AppColors().defaultColor;
        satColor = AppColors().defaultColor;
        sunColor = AppColors().defaultColor;
      });
    }else if(details.pointIndex == 1){
      setState(() {
        tueColor = Colors.amber;
        monColor = AppColors().defaultColor;
        wedColor = AppColors().defaultColor;
        thuColor = AppColors().defaultColor;
        friColor = AppColors().defaultColor;
        satColor = AppColors().defaultColor;
        sunColor = AppColors().defaultColor;
      });
    }else if(details.pointIndex == 2){
      setState(() {
        wedColor = Colors.amber;
        monColor = AppColors().defaultColor;
        tueColor = AppColors().defaultColor;
        thuColor = AppColors().defaultColor;
        friColor = AppColors().defaultColor;
        satColor = AppColors().defaultColor;
        sunColor = AppColors().defaultColor;
      });
    }else if(details.pointIndex == 3){
      setState(() {
        thuColor = Colors.amber;
        monColor = AppColors().defaultColor;
        tueColor = AppColors().defaultColor;
        wedColor = AppColors().defaultColor;
        friColor = AppColors().defaultColor;
        satColor = AppColors().defaultColor;
        sunColor = AppColors().defaultColor;
      });
    }else if(details.pointIndex == 4){
      setState(() {
        friColor = Colors.amber;
        monColor = AppColors().defaultColor;
        tueColor = AppColors().defaultColor;
        wedColor = AppColors().defaultColor;
        thuColor = AppColors().defaultColor;
        satColor = AppColors().defaultColor;
        sunColor = AppColors().defaultColor;
      });
    }else if(details.pointIndex == 5){
      setState(() {
        satColor = Colors.amber;
        monColor = AppColors().defaultColor;
        tueColor = AppColors().defaultColor;
        wedColor = AppColors().defaultColor;
        thuColor = AppColors().defaultColor;
        friColor = AppColors().defaultColor;
        sunColor = AppColors().defaultColor;
      });
    }else if(details.pointIndex == 6){
      setState(() {
        sunColor = Colors.amber;
        monColor = AppColors().defaultColor;
        tueColor = AppColors().defaultColor;
        wedColor = AppColors().defaultColor;
        thuColor = AppColors().defaultColor;
        friColor = AppColors().defaultColor;
        satColor = AppColors().defaultColor;
      });
    }
  }

  Widget chart(){
    return SizedBox(
      width: double.infinity,
      height: 230.h,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 16.sp), majorGridLines: const MajorGridLines(width: 0), axisLine: const AxisLine(width: 0), ),
          primaryYAxis: NumericAxis(isVisible: false, majorGridLines: const MajorGridLines(width: 0), axisLine: const AxisLine(width: 0), ),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: '',
              borderColor: Colors.white,
              trackBorderWidth: 0.3,
              isTrackVisible: true,
              width: 0.2.w,
              spacing: 0.1.w,
              opacity: 0.9,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              trackColor: const Color(0xffFFC8C5).withOpacity(0.3),
              color: AppColors().defaultColor,
              pointColorMapper: (ChartData, int) => changeBarColor(int),
              onPointTap: (ChartPointDetails details) => getBarColor(details),
            ),
          ]),
    );
  }

  void getCurrentEmail() async{
    final prefs = await SharedPreferences.getInstance();
    _currentEmail = prefs.getString("currentEmail")!;
  }

  void getRepSalesTasks() async{
    await FirebaseFirestore.instance.collection("Tasks").get().then((value) {
      for (var doc in value.docs){
        if(doc.data()['employee_email'] == _currentEmail){
          allRepSalesTasks++;
        }

        if(doc.data()['employee_email'] == _currentEmail && doc.data()['isDone'] == true){
          repSalesCompletedTasks++;
        }

      }
      setState(() {

      });
    });
  }

  void getRepSalesName() async {
    final prefs = await SharedPreferences.getInstance();
    _currentEmail = prefs.getString("currentEmail")!;
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      for(var doc in value.docs){
        if(doc.data()['email'] == _currentEmail ){
          repSalesName = doc.data()['first_name'] +  doc.data()['last_name'];
print(doc.data()['email']);
        }
      }
    });
  setState(() {

  });
  print(repSalesName);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
