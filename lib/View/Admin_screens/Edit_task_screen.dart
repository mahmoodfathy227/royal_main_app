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

class EditTaskScreen extends StatefulWidget {

  EditTaskScreen({Key? key, required this.client, required this.durationTo, required this.TimeTo, required this.descripttion, required this.timeto, required this.fromDate, required this.fromTime, required this.description, required this.assignToName, required this.employeeEmail, required this.latitude, required this.longitude, required this.location, required this.phoneNumber,}) : super(key: key);

final String client;
  final String durationTo;
  final String TimeTo;
  final String descripttion;
  final String timeto;
  final String fromDate;
  final String fromTime;
  final String description;
  final String assignToName;
  final String employeeEmail;
  final double latitude;
  final double longitude;
  final String location;
  final String phoneNumber;


  @override
  State<EditTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<EditTaskScreen>{
TextEditingController descrptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
   TextEditingController _locationController  = TextEditingController();
   TextEditingController _phoneController  = TextEditingController();

  DateTime? _currentDateFrom;
  DateTime? _currentTimeFrom;

  DateTime? _currentDateTo;
  DateTime? _currentTimeTo;

  String? clientName;
  String? assignToName;
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
  ClientModel? searchedValue;
double? updatedLatitude ;
double? updatedLongitude ;

  getDateFrom(){
    if(_currentDateFrom == null){
      String? date;
      String comingFromDate = widget.fromDate.replaceAll("/", "-");
      String day = comingFromDate.split("-").elementAt(0);
      String month = comingFromDate.split("-").elementAt(1);
      String year = comingFromDate.split("-").elementAt(2);
      setState(() {
        date = DateFormat('dd/MM/yyyy').format(DateTime.parse("$year-$month-$day"));
        fromDate = date;
      });
      return date;
    } else {
      String? date;
      setState(() {
        date = DateFormat('dd/MM/yyyy').format(_currentDateFrom!);
        fromDate = date;
      });
      return date;
    }

  }

getDateTo(){
  if(_currentDateTo == null){
    String comingToDate = widget.durationTo.replaceAll("/", "-");
    String day = comingToDate.split("-").elementAt(0);
    String month = comingToDate.split("-").elementAt(1);
    String year = comingToDate.split("-").elementAt(2);
    String? date;
    setState(() {
      date = DateFormat('dd/MM/yyyy').format(DateTime.parse("$year-$month-$day"));
      toDate = date;
    });
    return date;
  } else {
    String? date;
    setState(() {
      date = DateFormat('dd/MM/yyyy').format(_currentDateTo!);
      toDate = date;
    });
    return date;
  }

}

  getTimeFrom(){
    if(_currentTimeFrom == null){
      String? time;
      String comingFromDate = widget.fromDate.replaceAll("/", "-");
      String day = comingFromDate.split("-").elementAt(0);
      String month = comingFromDate.split("-").elementAt(1);
      String year = comingFromDate.split("-").elementAt(2);
      String newTimeFrom = widget.fromTime.replaceAll("PM", "");
      String anotherDate = newTimeFrom.replaceAll("AM", "");
      String lastDate = anotherDate.replaceAll(" ", "");
      String hour = lastDate.split(":").elementAt(0);
      int newHour =  int.parse(hour);
      String lastHour = (newHour+12).toString();
      String min = lastDate.split(":").elementAt(1);
      int newMin =  int.parse(min);
      String lastMin = (newMin+12).toString();
      time = DateFormat('h:mm a').format(DateTime.parse("$year-$month-$day $lastHour:$min:00"));
      fromTime = time;
      return time;
    } else {
      String? time;
      time = DateFormat('h:mm a').format(_currentTimeFrom!);
      fromTime = time;
      return time;
    }

  }



  getTimeTo(){
    if(_currentTimeTo == null){
      String? time;
      String comingFromDate = widget.fromDate.replaceAll("/", "-");
      String day = comingFromDate.split("-").elementAt(0);
      String month = comingFromDate.split("-").elementAt(1);
      String year = comingFromDate.split("-").elementAt(2);
      String newTimeFrom = widget.timeto.replaceAll("PM", "");
      String anotherDate = newTimeFrom.replaceAll("AM", "");
      String lastDate = anotherDate.replaceAll(" ", "");
      String hour = lastDate.split(":").elementAt(0);
      int newHour =  int.parse(hour);
      String lastHour = (newHour+12).toString();
      String min = lastDate.split(":").elementAt(1);
      int newMin =  int.parse(min);
      String lastMin = (newMin+12).toString();
      time = DateFormat('h:mm a').format(DateTime.parse("$year-$month-$day $lastHour:$min:00"));


      toTime = time;
      return time;
    } else {
      String? time;
      time = DateFormat('h:mm a').format(_currentTimeTo!);
      toTime = time;
      return time;
    }

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

  getClientsNamesList() async {
    await client.then((value) {
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
    print("this is cline list Done ${clientList}");
  }


  @override
  void initState() {
    super.initState();

    user = Provider.of<UserOutputs>(context, listen: false).getUsers();
    client = Provider.of<UserOutputs>(context, listen: false).getClients();
    getUsersNamesList();
    getClientsNamesList();
    _locationController.text = widget.location;
    _phoneController.text = widget.phoneNumber;

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
                    "Edit Task",
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
                              controller: descrptionController,
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
                                text: 'Edit',
                                onPressed: (){
                                  _formKey.currentState!.save();
                                  if(true){

                                    CreateTaskInputs(
                                      clientName: clientName == null ? widget.client : clientName!,
                                      assignToName: assignToName == null ? widget.assignToName : assignToName!,
                                      fromDate: fromDate == null ? widget.fromDate : fromDate!,
                                      toDate: toDate == null ? widget.durationTo : toDate!,
                                      fromTime: fromTime == null ? widget.fromTime : fromTime!,
                                      toTime: toTime == null ? widget.timeto : toTime!,
                                      description: description == null ? widget.description : description!,
                                      latitude:
                                      updatedLatitude == null ?  widget.latitude :  updatedLatitude! ,

                                      longitude:
                                      updatedLongitude == null ?  widget.latitude :  updatedLongitude! ,
                                      client_locationName:_locationController.text,
                                      client_phoneNumber: _phoneController.text,
                                      employee_email: widget.employeeEmail,

                                    ).updateTaskInPipeLine(widget.client);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      content: Text(
                                        'This task is Updated',
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

                      clientName = value;
                    });
                    for(var element in clientList){
                      if(element.name == clientName){
                        print(element.locationName);
                        setState(() {
                          _locationController.text = element.locationName;
                          _phoneController.text = element.phoneNumber;
                          updatedLatitude = element.latitude;
                          updatedLongitude = element.longitude;


                        });
                        print(_locationController.text);
                      } else {

                      }
                    }
                    setState(() {

                    });
                  },
                  selectedItem: widget.client,
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
                    print(newdate);

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
