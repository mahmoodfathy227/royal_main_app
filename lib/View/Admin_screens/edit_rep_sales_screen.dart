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
import 'package:royal_marketing/Model/user_model.dart';
import 'package:royal_marketing/View/Screens/view_task_collect_screen.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';
import 'package:royal_marketing/View/Widgets/custom_delete_dialog.dart';

import '../../Controller/create_task_inputs.dart';
import '../../Controller/task_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_pipe_line_list_item.dart';
import 'main_page_admin.dart';

class EditRepSalesScreen extends StatefulWidget {
  const EditRepSalesScreen({Key? key}) : super(key: key);

  @override
  State<EditRepSalesScreen> createState() => _CreatePipeLineScreenState();
}

class _CreatePipeLineScreenState extends State<EditRepSalesScreen> {

  bool enableCheckBox = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _currentDateFrom = DateTime.now();
  DateTime _currentTimeFrom = DateTime.now();

  DateTime _currentDateTo = DateTime.now();
  DateTime _currentTimeTo = DateTime.now();
  String clientLocation = "";
  double clientLocationLatitude = 0.0;
  double clientLocationLongitude = 0.0;
  String clientPhoneNumber = "";
  String? fullName;
  String? clientName;
  String? assignToName;
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  String? description;
  String? pipeLineName;
  ClientModel? selectedClient;
  UserModel? selectedAssignTo;
  List<ClientModel> clientList = <ClientModel>[];
  List<UserModel> assignToList = <UserModel>[];
  late Future<List<dynamic>> user;
  late Future<List<dynamic>> client;
  late Future<List<dynamic>> task;
  // late Future<List<dynamic>> pipeLineGetter;
  Future? taskAndUser;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
String first_name = "";
  String last_name = "";
  String phone_number = "";


  int indexOfAssignToList = 0;
  String employee_email = "";
  getDateFrom(){
    String? date;
    setState(() {
      date = DateFormat('dd/MM/yyyy').format(_currentDateFrom);
      fromDate = date;
    });
    return date;
  }

  getTimeFrom(){
    String? time;
    time = DateFormat('h:mm a').format(_currentTimeFrom);
    fromTime = time;
    return time;
  }

  getDateTo(){
    String? date;
    setState(() {
      date = DateFormat('dd/MM/yyyy').format(_currentDateTo);
      toDate = date;
    });
    return date;
  }

  getTimeTo(){
    String? time;
    time = DateFormat('h:mm a').format(_currentTimeTo);
    toTime = time;
    return time;
  }

  getUsersNamesList() {
    user.then((value) {
      for(int i=0;i<value.length;i++){
        setState(() {

          assignToList.add(UserModel(
              first_name: value[i].first_name,
              last_name: value[i].last_name,
              phone_number: value[i].phone_number,
              email: value[i].email,
              user_role: value[i].user_role,
              user_type: value[i].user_type,
              agreed_or_not: value[i].agreed_or_not)

          );
        });
      }
    });

  }

  getClientNamesList() {
    client.then((value) {
      for(int i=0;i<value.length;i++){
        setState(() {
          clientList.add(
              ClientModel(
                name: value[i].name,  email: value[i].email ,
                latitude:  value[i].latitude,
                locationName: value[i].locationName,
                longitude:  value[i].longitude,
                phoneNumber:  value[i].phoneNumber,              ));
        });
      }
    });

  }


  @override
  void initState() {
    user = Provider.of<UserOutputs>(context, listen: false).getUsers();
    client = Provider.of<UserOutputs>(context, listen: false).getClients();
    task = Provider.of<TaskOutputs>(context, listen: false).getTasks();
    getUsersNamesList();
    getClientNamesList();
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
                    "Edit Rep Sales",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 22.w,),
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.check, color: Colors.white, size: 25.w,)
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
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text("Choose Pipe Line Employee",
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
                                    child: assignToDropDowButtonFromField(),
                                  )
                                ],),
                            ),
                          ),

                          //first Name
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Rep Sales first Name",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: TextFormField(
                              controller: firstNameController,
                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                first_name = value;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter description";
                                }
                                return null;
                              },
                              maxLines: 1,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Rep sales Name",
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
                          ),
                          //last Name
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Rep Sales last Name",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: TextFormField(
                              controller: lastNameController,
                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                last_name = value;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter description";
                                }
                                return null;
                              },
                              maxLines: 1,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Rep sales Last Name",
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
                          ),
                          //Email
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Rep sales Email",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                              ],
                            ),
                          ),


                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: TextFormField(
                              readOnly: true,
                              controller: emailController,
                              onSaved: (value){
                                description = value;
                              },

                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter description";
                                }
                                return null;
                              },
                              maxLines: 1,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Rep sales Email",
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
                          ),
                          //phone number
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Rep sales Phone Number",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                              ],
                            ),
                          ),


                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: TextFormField(
                              controller: phoneController,
                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                phone_number = value;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter description";
                                }
                                return null;
                              },
                              maxLines: 1,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Rep sales Phone Number",
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
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: "Update",
                                onPressed: (){
                                  _formKey.currentState!.save();
                                  if(_formKey.currentState!.validate()){
                                    if(first_name.isEmpty){
                                      first_name = firstNameController.text;
                                    }
                                    if(last_name.isEmpty){
                                      last_name = lastNameController.text;
                                    }
                                    if(phone_number.isEmpty){
                                      phone_number = phoneController.text;
                                    }
Provider.of<UserOutputs>(context, listen: false).updateRepsales(
    email: emailController.text,
first_name: first_name,
  last_name: last_name,
  phone_number: phone_number

);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      content: Text(
                                        'Updated Successfully',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));

                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      content: Text(
                                        'Please fill all the fields',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                                  }
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: "Delete",
                                onPressed: (){
showDialog(context: context, builder: (context)=> DeleteDialog(DeleteFunction: () async{

  var gottenDoc =  await FirebaseFirestore.instance.collection("Users").
  where("email" , isEqualTo:emailController.text ).get();

  DocumentReference docReference = gottenDoc.docs[0].reference;
  await FirebaseFirestore.instance.collection("Users").
  doc(docReference.id).delete().then((value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      backgroundColor: Colors.deepPurpleAccent,
      content: Text(
        'This Rep Sales is Deleted',
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp),
        textAlign: TextAlign.center,
      ),
    ));
    Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));
  });

}));
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









  Widget assignToDropDowButtonFromField(){
    List<String> employeesNames = [];
    for(var employee in assignToList){
      employeesNames.add(employee.first_name+ employee.last_name);
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
            items: employeesNames,

            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Select Employee",
                hintText: "Select Employee",
              ),
            ),
            onChanged: (value){

              assignToName = value ;
              setState(() {

                assignToName = value;
                // indexOfAssignToList = assignToList.indexOf(value);
                for(var element in assignToList){
                  if(element.first_name+ element.last_name == assignToName){
                    setState(() {

                      emailController.text = element.email;
                      firstNameController.text = element.first_name;
                      lastNameController.text = element.last_name;
                      phoneController.text = element.phone_number;
                      indexOfAssignToList = assignToList.indexOf(element);
                    });
                  } else {

                  }
                }
              });
            },
            selectedItem: selectedClient?.name,
          ),
        ),





      ],
    );
  }



}