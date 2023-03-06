import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../Controller/task_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_button.dart';
import 'home_screen_rep.dart';

class ApplyAndReportOrderScreen extends StatefulWidget {
  const ApplyAndReportOrderScreen({Key? key, this.clientName}) : super(key: key);
 final clientName;
  @override
  State<ApplyAndReportOrderScreen> createState() => _ApplyAndReportOrderScreenState();
}

class _ApplyAndReportOrderScreenState extends State<ApplyAndReportOrderScreen> {
  String value = "order";
  TextEditingController descriptionController = TextEditingController();
  @override
void initState() {
    descriptionController.text = "";
    super.initState();
  }
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
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white,),
                  ),
                  SizedBox(width: 40.w,),
                  Text(
                    "Apply and Report",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
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
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 35.h),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(25)),
                              child: Container(
                                width: double.infinity,
                                height: 180.h,
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.person, color: AppColors().defaultColor, size: 35.w,),
                                          SizedBox(width: 5.w,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ahmed Hossam",
                                                style: TextStyle(
                                                  color: AppColors().defaultColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "Accountant",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(top: 22.h),
                                            child: Text(
                                              "Duration To",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.w,),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_pin, color: AppColors().defaultColor, size: 35.w,),
                                          SizedBox(width: 5.w,),
                                          Text(
                                            "134, High street, \nOsman Mohamed, EG.",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset("assets/icons/Date_icon.svg", width: 32.w,),
                                          SizedBox(width: 5.w,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6),
                                            child: Text(
                                              "23/9/2022",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 5.w,),
                                          SvgPicture.asset("assets/icons/Phone_icon.svg", color: AppColors().defaultColor,width: 27.w,),
                                          SizedBox(width: 5.w,),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            child: Text(
                                              "(+XX)XXX-XXX-XXXX",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset("assets/icons/Clock_icon.svg", width: 25.w,),
                                          SizedBox(width: 5.w,),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            child: Text(
                                              "10:30 PM",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.w,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: Container(
                              width: double.infinity,
                              height: 110.h,
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reason of Visit",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(2),
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Colors.white,
                                          border: Border.all(color: Colors.black, width: 3.w, style: BorderStyle.solid),
                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            value = "order";
                                            setState(() {

                                            });
                                          },
                                          child: Icon(
                                            Icons.circle,
                                            size: 20.w,
                                            color:  value == "order" ? AppColors().defaultColor : Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text(
                                        "Order",
                                        style: TextStyle(
                                            color: Colors.black,
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
                                        child: GestureDetector(
                                          onTap: (){
                                            value = "collect";
                                            setState(() {

                                            });
                                          },
                                          child: Icon(
                                            Icons.circle,
                                            size: 20.w,
                                            color:  value == "collect" ? AppColors().defaultColor : Colors.white,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10.w,),
                                      Text(
                                        "Collect",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: Container(
                              width: double.infinity,
                              height: 90.h,
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                              color: Colors.grey[200],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Find Missing",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      value = "find missing";
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(2),
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.white,
                                        border: Border.all(color: Colors.black, width: 3.w, style: BorderStyle.solid),
                                      ),
                                      child: Icon(
                                        Icons.circle,
                                        size: 20.w,
                                        color:  value == "find missing" ?AppColors().defaultColor : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          descriptionTextFormField(),
                          SizedBox(height: 15.h,),
                          fileAttachment(),
                          SizedBox(height: 15.h,),
                          saveLocationTextFormField(),
                          SizedBox(height: 20.h,),
                          Center(
                            child: CustomButton(
                              text: "Report",
                              onPressed: () async{
                              await  Provider.of<TaskOutputs>(
                                  context , listen: false).
                              updateTask(widget.clientName,
                                  value.toString(),
                                  descriptionController.text.toString()
                              );
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                backgroundColor: Colors.white,
                                content: Row(
                                  children: const [
                                    Text("Deliverd Succefully",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,),
                                    SizedBox(width: 10,),
                                    Icon(CupertinoIcons.check_mark_circled_solid , color: Colors.green,)
                                  ],
                                ),
                                duration: Duration(seconds: 2),
                              ));
                              // Provider.of<TaskOutputs>(context , listen: false).updateTask(widget.clientName);
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomeScreenRep()), (route) => false);
                              // Future.delayed(const Duration(seconds: 1), (){
                              //   Navigator.pop(context);
                              // });
                              // Navigator.pop(context);

                              },
                            ),
                          ),
                          SizedBox(height: 20.h,),
                        ],
                      ),
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
  updateTask( clientName , userName) async{
    String docID = "";
    await FirebaseFirestore.instance.collection("Tasks").where("client_name" ,
        isEqualTo: clientName
    ).get().then((value) {
      docID = value.docs.first.id;
      print(value.docs.first.id);
    });
    FirebaseFirestore.instance.collection("Tasks").doc(docID).update({
      "isDone" : true,
      'reason_of_visit' : "good",
      'rep_sales_descroption' : "good",
    });
    String docID2 = "";
    await FirebaseFirestore.instance.collection("PipeLine").doc(userName).collection("Tasks").
    where("client_name" ,
        isEqualTo: clientName
    ).get().then((value) {
      docID2 = value.docs.first.id;
      print(value.docs.first.id);
    });

    FirebaseFirestore.instance.collection("PipeLine").doc(userName).collection("Tasks").doc(docID2).
    update({
      "isDone" : true,
      'reason_of_visit' : "good",
      'rep_sales_descroption' : "good",
    });

  }
  Widget fileAttachment(){
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: double.infinity,
        height: 370.h,
        color: Colors.grey[200],
        padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 3.r, bottom: 20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "File Attachment",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
                  onPressed: () {
                    pickuserimage(context);

                  }, icon: Icon(Icons.camera_alt_rounded, color: AppColors().defaultColor, size: 28.w,),
                ),
              ],
            ),
            SizedBox(height: 25.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/Excel_icon.svg", width: 30.w,),
                const SizedBox(width: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data-structures.xls",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "1.4 MB",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.clear_rounded, color: AppColors().defaultColor, size: 25.w,),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/Jpg_icon.svg", width: 30.w,),
                SizedBox(width: 15.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team-Photos.jpg",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "34 MB",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.clear_rounded, color: AppColors().defaultColor, size: 25.w,),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/Pdf_icon.svg", width: 30.w,),
                SizedBox(width: 15.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User-journey.pdf",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "12 MB",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12.h,),
                    LinearPercentIndicator(
                      width: 150.w,
                      lineHeight: 8.h,
                      percent: 0.5,
                      backgroundColor: Colors.blue.withOpacity(0.3),
                      progressColor: Colors.blue,
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppColors().defaultColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget descriptionTextFormField(){
    return TextFormField(
      controller: descriptionController,
      //onSaved: onSave,
      //validator: validator,
      maxLines: 5,
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
    );
  }
  final ImagePicker picker = ImagePicker();
  var imageTemporay2;
  var userimage;
  var lastphoto;
  Future  pickuserimage (
     context
      )
  async{

    var pickedfile = await picker.pickImage
      (source: ImageSource.camera,
    );
    if(pickedfile != null) {

      imageTemporay2 = File(pickedfile.path);

      userimage = imageTemporay2;
      print('i replaced that good');


    }
    else {


      print ('no image selected');
    }
  }
  Widget saveLocationTextFormField(){
    return TextFormField(
      readOnly: true,
      //onSaved: onSave,
      //validator: validator,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: "Save Location",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: Icon(Icons.location_pin, color: AppColors().defaultColor, size: 30.w,),
        contentPadding: EdgeInsets.all(25.r),
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
    );
  }
}
