import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';

import '../../Controller/create_user_inputs.dart';
import '../../contants.dart';
import '../Widgets/image_profile_and_notification.dart';

class CreateSupervisorScreen extends StatefulWidget {
  const CreateSupervisorScreen({Key? key}) : super(key: key);

  @override
  _CreateSupervisorScreenState createState() => _CreateSupervisorScreenState();
}

class _CreateSupervisorScreenState extends State<CreateSupervisorScreen> {
  TextEditingController supervisorNameController = TextEditingController();
  TextEditingController supervisorEmailController = TextEditingController();
  TextEditingController supervisorPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors().defaultColor,
        centerTitle: true,
        toolbarHeight: 60.h,
        title: Text(
          "Create Supervisor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: ImageProfileAndNotification()
            .imageProfileAndNotificationWithPoint(context),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
                      child: Image.asset(
                        "assets/images/Person_image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Container(
                    width: 250.w,
                    height: 99.h,
                    child: TextFormField(
                      controller: supervisorNameController,
                      onSaved: (value){

                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter Supervisor name";
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Supervisor Name",
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding: EdgeInsets.all(18.r),
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
                  )




                ],
              ),
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
        child: Icon(Icons.email , color: AppColors().defaultColor,)
      ),
    ),
    SizedBox(
      width: 6.w,
    ),
    Container(
      width: 250.w,
      height: 99.h,
      child:  TextFormField(
        controller: supervisorEmailController,
        onSaved: (value){

        },
        validator: (value){
          if(value!.isEmpty){
            return "Please enter Supervisor email";
          }
          return null;
        },
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.sp,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: "Supervisor Email",
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: EdgeInsets.all(18.r),
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
    )
  ],
),
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
                      child:  Icon(Icons.visibility , color: AppColors().defaultColor,)
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Container(
                    width: 250.w,
                    height: 99.h,
                    child:  TextFormField(
                      controller: supervisorPasswordController,
                      onSaved: (value){

                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter Supervisor Password";
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Supervisor Password",
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        contentPadding: EdgeInsets.all(18.r),
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
                  )
                ],
              ),
              CustomButton(text: "Submit", onPressed: (){

 Provider.of<TaskOutputs>(context , listen: false).createSuperVisor(
   supervisorNameController.text, context,
     supervisorEmailController.text,
     supervisorPasswordController.text

 );

              })


            ],
          ),
        ),
      ),
    );
  }
}
