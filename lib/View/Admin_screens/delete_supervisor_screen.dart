import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/user_outputs.dart';
import 'package:royal_marketing/Model/client_model.dart';
import 'package:royal_marketing/Model/supervisor_model.dart';
import 'package:royal_marketing/Model/user_model.dart';
import 'package:royal_marketing/View/Screens/view_task_collect_screen.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';

import '../../Controller/create_task_inputs.dart';
import '../../Controller/task_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_delete_dialog.dart';
import '../Widgets/custom_pipe_line_list_item.dart';
import 'main_page_admin.dart';
class DeleteSupervisorScreen extends StatefulWidget {
  const DeleteSupervisorScreen({Key? key}) : super(key: key);

  @override
  State<DeleteSupervisorScreen> createState() => _CreatePipeLineScreenState();
}

class _CreatePipeLineScreenState extends State<DeleteSupervisorScreen> {

  bool enableCheckBox = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late Future<List<dynamic>> supervisors;

List<SupervisorModel> supervisorsList = [];

  int indexOfAssignToList = 0;
  String employee_email = "";
  String selectedSupervisor = "";












  @override
  void initState() {
    supervisors = Provider.of<UserOutputs>(context, listen: false).getSupervisors();

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
                  SizedBox(width: 25.w,),
                  Text(
                    "Delete Supervisor",
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
            Flexible(
              fit: FlexFit.loose,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //choose supervisor
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text("Choose Supervisor",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),

                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 80 ,
                                    height: 80.h,
                                    child: supervisorDropDowButtonFromField(),
                                  )
                                ],),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: "Delete",
                                onPressed: (){
                                  if(selectedSupervisor.isNotEmpty){
                                    showDialog(context: context, builder: (context)=> DeleteDialog(DeleteFunction: () async{

                                      var gottenDoc =  await FirebaseFirestore.instance.collection("Supervisors").
                                      where("name" , isEqualTo:selectedSupervisor ).get();

                                      DocumentReference docReference = gottenDoc.docs[0].reference;
                                      await FirebaseFirestore.instance.collection("Supervisors").
                                      doc(docReference.id).delete().then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Colors.deepPurpleAccent,
                                          content: Text(
                                            'This Supervisor is Deleted',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));
                                      });

                                    }));
                                  }

                                },
                              ),
                            ),
                          ),

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









  Widget supervisorDropDowButtonFromField(){
    List<String> supervisorNames = [];
    for(var supervisor in Provider.of<UserOutputs>(context).supervisorList){
      supervisorNames.add(supervisor.name);
    }
    return  Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          child: Icon(
            Icons.person,
            color: AppColors().defaultColor,
            size: 35.w,
          ),
        ),
        Expanded(
          child: DropdownSearch<String>(
            popupProps:  const PopupProps.dialog(
              showSelectedItems: true,
              showSearchBox: true,


            ),
            items: supervisorNames,

            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Select Supervisor",
                hintText: "Select Supervisor",
              ),
            ),
            onChanged: (value){


              setState(() {

                selectedSupervisor = value! ;


              });
            },
            selectedItem: selectedSupervisor,
          ),
        ),





      ],
    );
  }



}
