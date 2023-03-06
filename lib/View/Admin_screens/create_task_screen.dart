import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/create_task_inputs.dart';
import 'package:royal_marketing/Model/user_model.dart';
import 'package:royal_marketing/View/Admin_screens/main_page_admin.dart';
import 'package:royal_marketing/contants.dart';


import '../../Controller/task_outputs.dart';
import '../../Controller/user_outputs.dart';
import '../../Model/client_model.dart';
import '../Widgets/custom_button.dart';
import 'Map.dart';
import 'SearchClientScreen.dart';

class CreateTaskScreen extends StatefulWidget {

   CreateTaskScreen({Key? key, required this.searchedValue}) : super(key: key);

final dynamic searchedValue;
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController  = TextEditingController();
  final TextEditingController _phoneController  = TextEditingController();

  DateTime _currentDateFrom = DateTime.now();
  DateTime _currentTimeFrom = DateTime.now();

  DateTime _currentDateTo = DateTime.now();
  DateTime _currentTimeTo = DateTime.now();

  String clientName = "";
  String assignToName = "";
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  String? description;
  ClientModel? selectedClient;
  UserModel? selectedAssignTo;
  List<ClientModel> clientList = <ClientModel>[];
  List<UserModel> assignToList = <UserModel>[];
  int indexOfAssignToList = 0;
  late Future<List<dynamic>> user;
  late Future<List<dynamic>> client;
 var _client_lat;
  var _client_lng;
  var _client_location;

  ClientModel? searchedValue;

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
          // clientList.add(ClientModel(name: value[i].first_name + " " + value[i].last_name, email: value[i].email));
          assignToList.add(UserModel(
              first_name: value[i].first_name,
              last_name: value[i].last_name,
              phone_number:value[i].phone_number,
              email: value[i].email,
              user_role: value[i].user_role,
              user_type: value[i].user_role,
              agreed_or_not: value[i].agreed_or_not)
          );

        });
      }
    });
  }

  getClientsNamesList(){
    client.then((value) {
      for(int i=0;i<value.length;i++){
        setState(() {
          clientList.add(ClientModel(
            name: value[i].name ,
            email: value[i].email ,
            latitude:  value[i].latitude,
            locationName: value[i].locationName,
            longitude:  value[i].longitude,
            phoneNumber:  value[i].phoneNumber,

          ));
        });
      }
    });
  }


  @override
  void initState() {
    super.initState();

    user = Provider.of<UserOutputs>(context, listen: false).getUsers();
    client = Provider.of<UserOutputs>(context, listen: false).getClients();
    getUsersNamesList();
    getClientsNamesList();
checkIfClientChecked();
  }

  checkIfClientChecked(){
    extractClientData(searchedValue);
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
                  SizedBox(width: 80.w,),
                  Text(
                    "Add Task ",
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
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
                         child:
                      clientDropDowButtonFromField()
                          ),
SizedBox(height: 12,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child: assignToDropDowButtonFromField(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: SizedBox(
                              width: double.infinity,
                              height: 170.h,
                              child: Card(
                                color: Colors.grey[200],
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                                  child: FutureBuilder(
                                    future: user,
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.grey[200],
                                            color: AppColors().defaultColor,
                                          ),
                                        );
                                      } else if(snapshot.hasError){
                                        return const Center(
                                          child: Text("Error"),
                                        );
                                      } else {
                                        if(snapshot.hasData){
                                          if(assignToList.isNotEmpty){
                                            //Assign To
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "To",
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  snapshot.data[indexOfAssignToList].first_name + " "+ snapshot.data[0].last_name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                // Text(
                                                //   snapshot.data[indexOfAssignToList].address,
                                                //   style: TextStyle(
                                                //     color: Colors.black,
                                                //     fontSize: 17.sp,
                                                //     fontWeight: FontWeight.w600,
                                                //   ),
                                                // ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  snapshot.data[indexOfAssignToList].email,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  snapshot.data[indexOfAssignToList].phone_number,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "To",
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  "Name",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  "Address",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 3.h,),
                                                Text(
                                                  "Phone number",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        } else {
                                          return const Center(
                                            child: Text("No data"),
                                          );
                                        }
                                      }
                                    },),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child:   TextFormField(
                              readOnly: true,

                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Employee Email",
                                filled: true,
                                fillColor: Colors.grey[200],
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
                          SizedBox(height: 12,),

                          //Location
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child:   TextFormField(
                              // validator: (value) {
                              //   if (_locationController.text.isEmpty) {
                              //     return 'Please enter Location';
                              //   }
                              //   return null;
                              // },



                              readOnly: true,
                              controller: _locationController,
                              decoration: InputDecoration(


                                hintText:   "Client Location",
                                filled: true,
                                fillColor: Colors.grey[200],
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
                          SizedBox(height: 12,),
                          //Phone
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child:   TextFormField(

                              // validator: (val){
                              //   if (_phoneController.text.isEmpty) {
                              //     return 'Please enter phone Number';
                              //   }
                              //   return null;
                              // } ,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                hintText: "Client Phone Number",
                                filled: true,
                                fillColor: Colors.grey[200],
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
                            padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                            child: Text(
                              "Duration From",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    dateDurationFrom();
                                  },
                                  child: SizedBox(
                                    width: 145.w,
                                    height: 55.h,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset("assets/icons/Date_icon.svg", width: 33.w,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w ,vertical: 8.h),
                                              child: Text(
                                                getDateFrom(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    timeDurationFrom();
                                  },
                                  child: SizedBox(
                                    width: 145.w,
                                    height: 55.h,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w ,vertical: 8.h),
                                              child: Text(
                                                getTimeFrom(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.sp,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                            child: Text(
                              "Duration To",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    dateDurationTo();
                                  },
                                  child: SizedBox(
                                    width: 145.w,
                                    height: 55.h,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset("assets/icons/Date_icon.svg", width: 33.w,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w ,vertical: 8.h),
                                              child: Text(
                                                getDateTo(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    timeDurationTo();
                                  },
                                  child: SizedBox(
                                    width: 145.w,
                                    height: 55.h,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.w ,vertical: 8.h),
                                              child: Text(
                                                getTimeTo(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.sp,
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 10.h),
                            child: TextFormField(
                              onSaved: (value) {
                                description = value;
                              },
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Please enter description';
                              //   }
                              //   return null;
                              // },
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Add Description",
                                hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                contentPadding: EdgeInsets.all(20.r),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: 'Create',
                                onPressed: (){
                                  _formKey.currentState!.save();
                                  if(clientName.isNotEmpty && assignToName.isNotEmpty){

                                    print('$clientName, $assignToName, $fromDate, $toDate, $fromTime, $toTime, $description');
                                    print("my Latlng is ${Provider.of<TaskOutputs>(context, listen: false).locationLatlng}");
                                    CreateTaskInputs(
                                      clientName: clientName,
                                      assignToName: assignToName,
                                      fromDate: fromDate!,
                                      toDate: toDate!,
                                      fromTime: fromTime!,
                                      toTime: toTime!,
                                      description: description!,
                                      latitude: _client_lat ,
                                      longitude: _client_lng ,
                                      client_locationName: _client_location ,

                                      client_phoneNumber: _phoneController.text,
                                      employee_email: _emailController.text,

                                    ).createTaskInPipeLine(assignToName, context);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      content: Text(
                                        'The task is Created',
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
                                      content: Text(
                                        'Please fill all the fields',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.35,
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

  Widget clientDropDowButtonFromField(){
   List<String> clientNames = [];
    for(var client in clientList){
      clientNames.add(client.name);
    }
    return FutureBuilder(
      future: client,
      builder: (context , snapshot){
        if(snapshot.hasData){

          return Row(
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
                  items: clientNames,

                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select Client",
                      hintText: "Select Client",
                    ),
                  ),
                  onChanged: (value){
                    setState(() {

                      clientName = value!;
                    });
                    for(var element in clientList){
                      if(element.name == clientName){
                        print(element.locationName);

                        setState(() {
                          _client_lat = element.latitude;
                          _client_lng = element.longitude;
                          _client_location = element.locationName;
                          _locationController.text = element.locationName;
                          _phoneController.text = element.phoneNumber;


                        });
                        print(_locationController.text);
                      } else {

                      }
                    }
                    setState(() {

                    });
                  },
                  selectedItem: clientName,
                ),
              ),


              // DropdownButtonFormField<ClientModel>(
              //     isExpanded: true,
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Colors.grey[200],
              //       contentPadding: EdgeInsets.all(18.r),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: const BorderSide(color: Colors.white, width: 2.0),
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       disabledBorder: OutlineInputBorder(
              //         borderSide: const BorderSide(color: Colors.white, width: 2.0),
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: const BorderSide(color: Colors.white, width: 2.0),
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //     ),
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 20.sp,
              //       fontWeight: FontWeight.w600,
              //     ),
              //     hint: Padding(
              //       padding: EdgeInsets.only(left: 40.w),
              //       child: Text(
              //         "Client",
              //         style: TextStyle(
              //           color: Colors.black45,
              //           fontSize: 18.sp,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ),
              //     icon: Icon(
              //       Icons.keyboard_arrow_down_rounded,
              //       color: AppColors().defaultColor,
              //       size: 25.w,
              //     ),
              //     validator: (value){
              //       print(value);
              //
              //       if(value == null){
              //         return "Please enter client";
              //       }
              //       return null;
              //     },
              //     value: selectedClient,
              //     onSaved: (value){
              //       clientName = value!.name;
              //       for(var element in clientList){
              //         if(element.name == clientName){
              //           setState(() {
              //             print(element.locationName);
              //             _locationController.text = element.locationName;
              //             _phoneController.text = element.phoneNumber!;
              //           });
              //           Provider.of<TaskOutputs>(context, listen: false).registerClientData(
              //               element.locationName,
              //             element.latitude,
              //             element.longitude
              //           );
              //           print(_locationController.text);
              //
              //         } else {
              //
              //         }
              //       }
              //       setState(() {
              //
              //       });
              //     },
              //     onChanged: (ClientModel? value) {
              //       extractClientData(value);
              //     },
              //     items: clientList.map((ClientModel client) {
              //       return DropdownMenuItem<ClientModel>(
              //         value: client,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             (selectedClient == null)? Container(
              //               padding: EdgeInsets.all(8.r),
              //               child: Icon(
              //                 Icons.person,
              //                 color: AppColors().defaultColor,
              //                 size: 35.w,
              //               ),
              //             ): Container(padding: EdgeInsets.symmetric(horizontal: 18.w),),
              //             Text(
              //               client.name,
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 20.sp,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     }).toList(),
              //   ),


            ],
          );
        } else{

          return Center(child: CircularProgressIndicator(color: AppColors().defaultColor),);
        }
      },

    );
  }

  void extractClientData(ClientModel? value) {
     print(value);
if(searchedValue != null){
  setState(() {
    selectedClient = value;
    clientName = value!.name;
  });
  for(var element in clientList){
    if(element.name == clientName){
      print(element.locationName);
      setState(() {
        _locationController.text = element.locationName;
        _phoneController.text = element.phoneNumber!;


      });
      print(_locationController.text);
    } else {

    }
  }
  setState(() {

  });
} else {

}

  }

  Widget assignToDropDowButtonFromField(){
    List <String> PipeLineNames =  Provider.of<TaskOutputs>(context , listen: false).pepeLineNames;
    List<String> employeesNames = [];
    for(var employee in PipeLineNames ){
      employeesNames.add(employee.toString());
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
                labelText: "PipeLine Name",
                hintText: "PipeLine Name",
              ),
            ),
            onChanged: (value){

              assignToName = value! ;
              setState(() {

                assignToName = value;
                // indexOfAssignToList = assignToList.indexOf(value);
                for(var element in assignToList){
                  if(element.first_name+ element.last_name == assignToName){
                    setState(() {
                      _emailController.text = element.email;
                      indexOfAssignToList = assignToList.indexOf(element);
                    });
                  } else {

                  }
                }
              });
            },
            selectedItem: assignToName,
          ),
        ),





      ],
    );
    return Stack(
      children: [
        DropdownButtonFormField<UserModel>(
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
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
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: Text(
              "Assign To",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          icon: Icon(
            Icons.add,
            color: AppColors().defaultColor,
            size: 25.w,
          ),
          validator: (value){
            print(value);
            if(value == null){
              return "Please enter assign to";
            }
            return null;
          },
          value: selectedAssignTo,
          onSaved: (value){
            assignToName = value!.first_name ;
            setState(() {
              selectedAssignTo = value;
              assignToName = value.first_name + value.last_name;
              indexOfAssignToList = assignToList.indexOf(value);
              for(var element in assignToList){
                if(element.first_name == assignToName){
                  setState(() {
                    _emailController.text = element.email;

                  });
                } else {

                }
              }
            });
          },
          onChanged: (UserModel? value) {
            print(value);

            setState(() {
              selectedAssignTo = value;
              assignToName = value!.first_name;
              indexOfAssignToList = assignToList.indexOf(value);
              for(var element in assignToList){
                if(element.first_name == assignToName){
                  setState(() {
                    _emailController.text = element.email;

                  });
                } else {

                }
              }
            });
          },
          items: assignToList.map((UserModel user) {
            return DropdownMenuItem<UserModel>(
              value: user,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (selectedAssignTo == null)? Container(
                    padding: EdgeInsets.all(8.r),
                    child: Icon(
                      Icons.person,
                      color: AppColors().defaultColor,
                      size: 35.w,
                    ),
                  ): Container(padding: EdgeInsets.symmetric(horizontal: 18.w),),
                  Text(
                    user.first_name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        Container(
          padding: EdgeInsets.all(8.r),
          child: Icon(
            Icons.person,
            color: AppColors().defaultColor,
            size: 35.w,
          ),
        ),
      ],
    );
  }

  Future dateDurationFrom(){
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors().defaultColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          getDateFrom();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  backgroundColor: Colors.white,
                  onDateTimeChanged: (DateTime newdate) {
                    print("this is new Date ${newdate}");
                    _currentDateFrom = newdate;
                  },
                  maximumDate: DateTime(2050, 12, 30),
                  minimumYear: 2010,
                  maximumYear: 2050,
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ]);
      },
    );
  }

  Future timeDurationFrom(){
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 3,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              backgroundColor: Colors.white,
              onDateTimeChanged: (DateTime newdate) {
                print(newdate);
                setState(() {
                  _currentTimeFrom = newdate;
                });
              },
              minuteInterval: 1,
              mode: CupertinoDatePickerMode.time,
            ),
          ),
        );
      },
    );
  }

  Future dateDurationTo(){
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors().defaultColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        getDateFrom();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  backgroundColor: Colors.white,
                  onDateTimeChanged: (DateTime newdate) {
                    print(newdate);
                    _currentDateTo = newdate;
                  },
                  maximumDate: DateTime(2050, 12, 30),
                  minimumYear: 2010,
                  maximumYear: 2050,
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ]);
      },
    );
  }

  Future timeDurationTo(){
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 3,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              backgroundColor: Colors.white,
              onDateTimeChanged: (DateTime newdate) {
                print(newdate);
                setState(() {
                  _currentTimeTo = newdate;
                });
              },
              minuteInterval: 1,
              mode: CupertinoDatePickerMode.time,
            ),
          ),
        );
      },
    );
  }
}

// class ClientSeachDelegate extends SearchDelegate<ClientModel>  {
//   ClientSeachDelegate(this.clientList);
//     final List<ClientModel> clientList;
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var client in clientList) {
//       if (client.name.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(client.name);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//
//         var result = matchQuery[index];
//         return ListTile(
//           title: GestureDetector(
//             onTap: ()=> Navigator.pop(context),
//               child: Text(result)),
//         );
//       },
//     );
//   }
//
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var client in clientList) {
//       if (client.name.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(client.name);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: GestureDetector(
//             onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> CreateTaskScreen(searchedValue: result,))),
//               child: Text(result)),
//         );
//       },
//     );
//   }
// }
