import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/track_location.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';
import 'package:royal_marketing/View/Widgets/custom_delete_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/task_outputs.dart';
import '../../Controller/user_outputs.dart';
import '../../contants.dart';
import '../Rep.sales_Widgets/reschedule_dialog.dart';
import 'Edit_task_screen.dart';
import 'main_page_admin.dart';

class ViewEditDeletTaskScreen extends StatelessWidget {
  const ViewEditDeletTaskScreen({Key? key, required this.clientName, required this.locationName, required this.phoneNumber, required this.durationTo, required this.TimeTo, required this.descripttion, required this.fromDate, required this.fromTime, required this.assignToName, required this.employeeEmail, required this.latitude, required this.longitude}) : super(key: key);
  final String clientName;
  final String locationName;
  final String phoneNumber;
  final String descripttion;
  final String durationTo;
  final String TimeTo;
  final String fromDate;
  final String fromTime;
final String assignToName;
  final String employeeEmail;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white,),
                  ),
                  SizedBox(width: 75.w,),
                  Text(
                    "View Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 25.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Client Details",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              // TextButton(
                              //   onPressed: () {
                              //     showAlertDialogCanceled(context);
                              //   },
                              //   child: Text(
                              //     "Canceled ?!",
                              //     style: TextStyle(
                              //         color: AppColors().defaultColor,
                              //         fontSize: 20.sp,
                              //         fontWeight: FontWeight.w600),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.person, color: AppColors().defaultColor,
                                size: 35.w,),
                              SizedBox(width: 10.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    clientName,
                                    style: TextStyle(
                                      color: AppColors().defaultColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // Text(
                                  //   "Accountant",
                                  //   style: TextStyle(
                                  //     color: Colors.black54,
                                  //     fontSize: 18.sp,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_pin, color: AppColors()
                                  .defaultColor, size: 33.w,),
                              SizedBox(width: 11.w,),
                              Container(
                                width: 255,
                                child: Text(
                                  locationName,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Phone_icon.svg", color: AppColors()
                                  .defaultColor, width: 27.w,),
                              SizedBox(width: 16.w,),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Text(
                                  phoneNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        //Duration From
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text(
                            "Duration From",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Date_icon.svg",
                                width: 32.w,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Text(
                                  fromDate,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Clock_icon.svg", width: 25.w,),
                              SizedBox(width: 12.w,),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Text(
                                  fromTime,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        //Duration To
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text(
                            "Duration To",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Date_icon.svg",
                                width: 32.w,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Text(
                                  durationTo,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/Clock_icon.svg", width: 25.w,),
                              SizedBox(width: 12.w,),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Text(
                                  TimeTo,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text(
                            descripttion,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: CustomButton(
                              text: "Start",
                              onPressed: () async {
                                var pref =  await SharedPreferences.getInstance();
                                String? loginTag = pref.getString("loginTag");

                                if(loginTag != "salesRep"){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.purpleAccent,
                                          content: Text(
                                            'Available only for Rep sales',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                            textAlign: TextAlign.center,
                                          )));

                                } else  {

                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>   TrackLocation(
                                    clientName: clientName,
                                    longtitude: longitude,
                                    latitude: latitude,)));
                                }
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return const ApplyAndReportOrderScreen();
                                //     }));

                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                          child: Center(
                            child: SizedBox(
                              width: 320.w,
                              height: 65.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffF5F7FE),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.r))),
                                ),
                                onPressed: () async{
                                  var pref =  await SharedPreferences.getInstance();
                                  String? loginTag = pref.getString("loginTag");
                                  if(loginTag != "salesRep"){

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.purpleAccent,
                                            content: Text(
                                              'Available only for Rep sales',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp),
                                              textAlign: TextAlign.center,
                                            )));

                                  } else {
                                    showAlertDialogReschedule(context);
                                  }
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (BuildContext context) {
                                  //       return const ApplyAndReportOrderScreen();
                                  //     }));


                                },
                                child: Text(
                                    "Reschedule",
                                    style: TextStyle(
                                      color: AppColors().defaultColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        //Edit Task
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: CustomButton(
                            text: "Edit",
                            onPressed: () async {
Navigator.push(context, MaterialPageRoute(builder: (_)=> EditTaskScreen(

  client: clientName,
  descripttion: descripttion,
  durationTo: durationTo,
  TimeTo: TimeTo,
  fromDate: fromDate,
  fromTime: fromTime,
  timeto: TimeTo,
  description: descripttion,
  assignToName: assignToName ,
  employeeEmail: employeeEmail ,
  latitude: latitude ,
  longitude: longitude ,
  location: locationName,
  phoneNumber: phoneNumber,
)));
                            },
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                          child: Center(
                            child: SizedBox(
                              width: 320.w,
                              height: 65.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffF5F7FE),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.r))),
                                ),
                                onPressed: () async{
                                 showDialog(context: context, builder:
                                     (context)=>  DeleteDialog(
                                       DeleteFunction: ()async{
                                         var gottenDoc =  await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).collection("Tasks").
                                         where("client_name" , isEqualTo:clientName).get();
                                         DocumentReference docReference = gottenDoc.docs[0].reference;
                                         await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).collection("Tasks").
                                         doc(docReference.id).delete().then((value) {
                                           print("Deleted Succefully");
                                           ScaffoldMessenger.of(context)
                                               .showSnackBar(SnackBar(
                                             backgroundColor: Colors.deepPurpleAccent,
                                             content: Text(
                                               'This task is Deleted Succefully',
                                               style: TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 16.sp),
                                               textAlign: TextAlign.center,
                                             ),
                                           ));
                                           Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));
                                         });

                                       },
                                     ) );

                                },
                                child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: AppColors().defaultColor,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ),
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

  Future showAlertDialogCanceled(BuildContext context) {
    Dialog alert = Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 420.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white),
              padding: EdgeInsets.fromLTRB(15.r, 15.r, 15.r, 15.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Container(
                      width: double.infinity,
                      height: 95.h,
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reason of Visit",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.grey.shade600, width: 3.w, style: BorderStyle.solid),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Text(
                                "Order",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white,
                                  border: Border.all(color: Colors.black, width: 3.w, style: BorderStyle.solid),
                                ),
                                child: Icon(
                                  Icons.circle,
                                  size: 20.w,
                                  color: AppColors().defaultColor,
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Text(
                                "Collect",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    //onSaved: onSave,
                    //validator: validator,
                    maxLines: 4,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Add  Description",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.all(20.r),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Center(
                    child: CustomButton(
                      text: "Submit",
                      onPressed: (){

                      },
                    ),
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          ],
        ));

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future showAlertDialogReschedule(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const RescheduleDialog();
      },
    );
  }
}