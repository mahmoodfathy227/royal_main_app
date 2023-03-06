import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/View/Admin_screens/ViewEditDeletTaskPipeLine.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/view_task_screen.dart';
import 'package:royal_marketing/View/Widgets/custom_delete_dialog.dart';

import '../../contants.dart';
import '../Admin_screens/main_page_admin.dart';
class ViewTaskCollection extends StatefulWidget {
   ViewTaskCollection({Key? key, required this.pipeLineName}) : super(key: key);
final String pipeLineName;
  @override
  State<ViewTaskCollection> createState() => _ViewTaskCollectionState();
}

class _ViewTaskCollectionState extends State<ViewTaskCollection> {

  @override
  void initState() {
    Provider.of<TaskOutputs>(context , listen: false).getCustomPipeLineTasks(widget.pipeLineName);
    super.initState();
  }

  getDay( String date){
    String day = date.split('/').first;
    String month = date.split('/').elementAt(1);
    String year = date.split('/').elementAt(2);
    print("year is ${year}");
   DateTime thisDate =  DateTime.parse("$year-$month-$day");
print("done ${thisDate}");
    return DateFormat('EEEE').format(thisDate); /// e.g Thursday

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
backgroundColor: Colors.blueGrey,
      body:  SafeArea(
          child: SingleChildScrollView(
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
                        icon:  Icon(Icons.arrow_back, color: Colors.white,),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Pipe Line Name : ${widget.pipeLineName}",
                              style: TextStyle(
                                color:  Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Expanded(child: IconButton(onPressed: (){
                              showDialog(context: context, builder: (context)=>   DeleteDialog(DeleteFunction:
                                  ()async{
                                await FirebaseFirestore.instance.collection("PipeLine").doc(widget.pipeLineName).delete().then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    content: Text(
                                      'This PipeLine is Deleted',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));
                                });



                              }));


                            }, icon: Icon(Icons.delete_forever , size: 35,) , color: Colors.red,))
                          ],
                        ),
                      ),

                    ],
                  ),

                ),
                Provider.of<TaskOutputs>(context, listen: true).isCustomPipeLineTasksLoading ?
                const Center(child: CircularProgressIndicator(),) :

              Container(
                    width: double.infinity,
height: MediaQuery.of(context).size.height - 150.h ,
                    child:  Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks.isEmpty?
                    Center(child: Text("This pipe line is Empty ...",
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.white38
                    ),


                    ),) :

                    ListView.separated(

                        itemBuilder: (context , index) =>
                            Container(

                              child:
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>

                                    ViewEditDeletTaskScreen(
                                      durationTo: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toDate,
                                      descripttion: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].description,
                                      locationName: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].locationName,
                                      phoneNumber: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].client_phoneNumber,
                                      clientName:Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].clientName,
                                      TimeTo: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toTime,
                                      fromDate :  Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].fromDate,
                                      fromTime:  Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].fromTime,
                                      assignToName: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].assignToName,
                                      employeeEmail: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].employee_email ,
                                      longitude: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].longitude ,
                                      latitude:  Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].latitude ,


                                    ),

                                  ));
                                } ,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                                  child: Container(
                                    width: double.infinity,
                                    height: 550.h,
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                                Container(

                                                  child: Text(
                                                    "Client Name : ${Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].clientName}",
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  width: 200.w,
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
                                          "Assigned To ${Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].assignToName}",
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
                                              Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].fromDate,
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

                                              Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].fromDate,
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
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                                              child: SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                                            ),
                                            SizedBox(width: 12.w,),
                                            Text(
                                              Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].fromTime,

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
                                              Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toTime,
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
                                          Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].description,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        Text(
                                          "Visit Every:",
                                          style: TextStyle(
                                            color: AppColors().defaultColor,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,

                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        Text(
                                          getDay(Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].fromDate),
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          "Task Done:",
                                          style: TextStyle(
                                            color: AppColors().defaultColor,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,

                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        Text(
                                          Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].isDone == false ? "No" : "Yes",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),




                            ),
                        separatorBuilder:(context , index) => SizedBox(height: 5,),
                        itemCount: Provider.of<TaskOutputs>(context , listen: true).customPipeLineTasks.length),
                  ),

              ],
            ),
          ),
        ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 500,
          child: Provider.of<TaskOutputs>(context, listen: true).isCustomPipeLineTasksLoading ?
          Center(child: CircularProgressIndicator(),) :

          Container(
            width: 300,
            height: 300,
            child: ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context , index) =>
                    Container(
                      width: 250,
                      height: 250,
                      child: ViewTaskScreen(
                        durationTo: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toDate,
                        descripttion: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].description,
                        locationName: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].locationName,
                        phoneNumber: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].client_phoneNumber,
                        clientName:Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].clientName,
                        TimeTo: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toTime,
                      ),
                    ),
                separatorBuilder:(context , index) => SizedBox(height: 5,),
                itemCount: Provider.of<TaskOutputs>(context , listen: true).customPipeLineTasks.length),
          )
    //       FutureBuilder(
    //         future: Provider.of<TaskOutputs>(context).getCustomPipeLineTasks(widget.pipeLineName),
    //         builder: (context , snapshot){
    //           if(snapshot.connectionState == ConnectionState.waiting){
    //             return Center(child: const CircularProgressIndicator(),);
    //
    //           } else if (snapshot.hasData) {
    //             return Text(snapshot.data.toString());
    // }else {
    //             return           ListView.separated(
    //                 itemBuilder: (context , index) =>
    //                     ViewTaskScreen(
    //                   durationTo: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toDate,
    //                   descripttion: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].description,
    //                   locationName: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].locationName,
    //                   phoneNumber: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].client_phoneNumber,
    //                   clientName:Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].clientName,
    //                   TimeTo: Provider.of<TaskOutputs>(context, listen: true).customPipeLineTasks[index].toTime,
    //                 ),
    //                 separatorBuilder:(context , index) => SizedBox(height: 5,),
    //                 itemCount: Provider.of<TaskOutputs>(context , listen: true).customPipeLineTasks.length) ;
    //           }
    //           }
    //
    //       )



        ),
      ),
    );
  }
}
