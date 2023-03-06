
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/Model/task_model.dart';
import 'package:royal_marketing/View/Screens/pre_signin_screen.dart';
import 'package:royal_marketing/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Controller/task_outputs.dart';
import '../../Model/test_task_model.dart';
import '../Rep.sales_Screens/view_task_collection.dart';
import '../Screens/view_task_collect_screen.dart';
import '../Widgets/TeamViewer.dart';
import '../Widgets/custom_pipe_line_group.dart';
import '../Widgets/custom_pipe_line_list_item.dart';
import '../Widgets/custom_team_project_home_list_item.dart';
import '../Widgets/image_profile_and_notification.dart';
import '../Widgets/week_bar.dart';

class HomeScreenAdmin extends StatefulWidget {

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenAdmin> {

  int percentage = 99;
  Color colorManager = const Color.fromRGBO(229, 29, 41, 1);
  Color colorSupervisor = const Color.fromRGBO(192, 90, 96, 1);
  Color colorRepresintive = const Color.fromRGBO(255, 106, 98, 1);


  List<_ChartData> getChartData() {

    final List<_ChartData> chartData = <_ChartData>[
      _ChartData('Represintive', 7300, colorRepresintive),
      _ChartData('Supervisor', 8500, colorSupervisor),
      _ChartData('Manager', 9700, colorManager),
    ];

    return chartData;
  }
  late List<_ChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  // late Future<List<TestTaskModel>> pipeLineGetter;
  bool enableCheckBox = false;

var team;
  int clientCounts = 0;
  int supervisorCount = 0;
  int teamsCount = 0;
  int repSalesCount = 0;
  int allTasks = 0;
  int completedTasks = 0;
  @override
  void initState() {
    getClientsCount();
    getSupervisorsCount();
    getTeamsCount();
    getRepSalesCount();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    // pipeLineGetter =  Provider.of<TaskOutputs>(context, listen: false).getPipeLine();
    team = Provider.of<TaskOutputs>(context, listen: false);

Provider.of<TaskOutputs>(context , listen: false).getPipeLineNames();
    Provider.of<TeamOutputs>(context , listen: false).getTeams();

    super.initState();
  }
  void getClientsCount() async{
    await FirebaseFirestore.instance.collection("Clients").get().then((value) {
      print(value.size);
      this.clientCounts = value.size;
      setState(() {

      });
      return value.size;
    });
  }
  void getSupervisorsCount() async{
    await FirebaseFirestore.instance.collection("Supervisors").get().then((value) {
      print(value.size);
      this.supervisorCount = value.size;
      setState(() {

      });
      return value.size;
    });
  }
  void getTeamsCount() async{
    await FirebaseFirestore.instance.collection("Teams").get().then((value) {
      print(value.size);
      this.teamsCount = value.size;
      setState(() {

      });
      return value.size;
    });
  }
  void getRepSalesCount() async{
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      for(var doc in value.docs){
        if(doc.data()['user_type'] == 'Employee'){
          repSalesCount++;
        } else {}
      }
    });

  }

  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors().defaultColor,
        centerTitle: true,
        toolbarHeight: 60.h,
        title: Text(
          "Admin",
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
        actions: ImageProfileAndNotification().imageProfileAndNotificationWithPoint(context),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25))),
      ),
      body: Column(
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
                    padding: EdgeInsets.only(left: 15.r, top: 5.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Today's Completed Tasks",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Text(
                                "Minim dolor in amet nulla \nlaboris enim dolore consequaty.",
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
                        circularChart(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => getPercentageAndColorManager(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 20.h,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(229, 29, 41, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(width: 3.w,),
                                  Text(
                                    "Manager",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 6.w,),
                            GestureDetector(
                              onTap: () => getPercentageAndColorSupervisor(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 20.h,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(192, 90, 96, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(width: 3.w,),
                                  Text(
                                    "Supervisor",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 6.w,),
                            GestureDetector(
                              onTap: () => getPercentageAndColorRepresintive(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 20.h,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(255, 106, 98, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(width: 3.w,),
                                  Text(
                                    "Represintive",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Pipe lines",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15.h,),
                     Provider.of<TaskOutputs>(context).isTasksLoading ?
                     const Center(
                       child: CircularProgressIndicator(),
                     )

                         :
                     ListView.builder(
                       physics: const BouncingScrollPhysics(),
                       shrinkWrap: true,
                       itemCount:  Provider.of<TaskOutputs>(context , listen: true).pipeLinetasksCount.length,
                       itemBuilder: (BuildContext context, int index) {

                         return Padding(
                           padding: EdgeInsets.symmetric(vertical: 10.h),
                           child: GestureDetector(

                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (BuildContext context) {


                                       return ViewTaskCollection(
                                           pipeLineName: Provider.of<TaskOutputs>(context , listen: false).pepeLineNames[index]
                                       );
                                     }));
                                 onLongPress: () {
                                 };
                                 setState(() {
                                   enableCheckBox = true;
                                 });
                               },
                               child: CustomPipeLineGroup(
                                 pipeLineName: Provider.of<TaskOutputs>(context , listen: false).pepeLineNames[index],
                                 tasksNumber: Provider.of<TaskOutputs>(context , listen: false).pipeLinetasksCount[index],
                                 doneTasks: Provider.of<TaskOutputs>(context , listen: true).doneGroup[index] ,

                               )
                           ),
                         );
                       },)


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h,),
           Provider.of<TeamOutputs>(context).isTeamLoading ?
               const Center(child:
                 CircularProgressIndicator(),) :
           ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: Provider.of<TeamOutputs>(context).teamsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CustomTeamProjectHomeListItem(index: index,data: Provider.of<TeamOutputs>(context).teamsList,),

                );
              },
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
                Text("${clientCounts}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Clients",
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
                Text("${supervisorCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Supervisors",
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
                Text("${teamsCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Teams",
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
                Text("${repSalesCount}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),),
                Text("Rep Sales",
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

  changeChartBarColor(int value){
    switch (value) {
      case 0:
        return colorRepresintive;

      case 1:
        return colorSupervisor;

      case 2:
        return colorManager;

      default:
        return Colors.grey[200];
    }
  }

  getPercentageAndColorManager(){
    setState(() {
      percentage = ((_ChartData('Manager', 9700, const Color.fromRGBO(229, 29, 41, 1)).tasks / 10000) * 100).round();
      colorManager = const Color.fromRGBO(229, 29, 41, 1);
      colorSupervisor = Colors.grey.shade200;
      colorRepresintive = Colors.grey.shade200;
    });
  }
  getPercentageAndColorSupervisor(){
    setState(() {
      percentage = ((_ChartData('Supervisor', 8500, const Color.fromRGBO(192, 90, 96, 1)).tasks / 10000) * 100).round();
      colorSupervisor = const Color.fromRGBO(192, 90, 96, 1);
      colorManager = Colors.grey.shade200;
      colorRepresintive = Colors.grey.shade200;
    });
  }

  getPercentageAndColorRepresintive(){
    setState(() {
      percentage = ((_ChartData('Represintive', 7300, const Color.fromRGBO(255, 106, 98, 1)).tasks / 10000) * 100).round();
      colorRepresintive = const Color.fromRGBO(255, 106, 98, 1);
      colorManager = Colors.grey.shade200;
      colorSupervisor = Colors.grey.shade200;
    });
  }

  Widget circularChart(){
    return Expanded(
      child: SizedBox(
        height: 130.h,
        width: 200.w,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SfCircularChart(
              series: <CircularSeries<_ChartData, String>>[
                RadialBarSeries<_ChartData, String>(
                    dataSource: _chartData,
                    xValueMapper: (_ChartData data, _) => data.userType,
                    yValueMapper: (_ChartData data, _) => data.tasks,
                    pointColorMapper: (ChartData, int) => changeChartBarColor(int),
                    cornerStyle: CornerStyle.bothCurve,
                    radius: '100%',
                    innerRadius: '50%',
                    gap: '8%',
                    maximumValue: 10000)
              ],
            ),
            Positioned(
              top: 55.r,
              right: 45.r,
              child: Text(
                "$percentage%",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.userType, this.tasks, this.color);
  final String userType;
  final int tasks;
  Color color;
}

