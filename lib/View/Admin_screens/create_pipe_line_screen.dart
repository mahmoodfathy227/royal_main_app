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

import '../../Controller/create_task_inputs.dart';
import '../../Controller/task_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_pipe_line_list_item.dart';
import 'main_page_admin.dart';

class CreatePipeLineScreen extends StatefulWidget {
  const CreatePipeLineScreen({Key? key}) : super(key: key);

  @override
  State<CreatePipeLineScreen> createState() => _CreatePipeLineScreenState();
}

class _CreatePipeLineScreenState extends State<CreatePipeLineScreen> {

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
String fullName = "";
  String? clientName;
  String? assignToName;
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  String? description;
  String? pipeLineName;
  ClientModel? selectedClient;
  String newSelectedClient = "";
  UserModel? selectedAssignTo;
  List<ClientModel> clientList = <ClientModel>[];
  List<UserModel> assignToList = <UserModel>[];
  late Future<List<dynamic>> user;
  late Future<List<dynamic>> client;
  late Future<List<dynamic>> task;
  // late Future<List<dynamic>> pipeLineGetter;
  Future? taskAndUser;
  TextEditingController NameController = TextEditingController();
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
    /*for (int i = 0; i < clientList.length; i++) {
      int idx = clientList[i].name.indexOf(" ");
      users = Provider.of<UserOutputs>(context, listen: false).getAssignToUsers(
          clientList[i].name.substring(0, idx).trim(),
          clientList[i].name.substring(idx + 1).trim());
  }*/
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
                    "Create Pipe Line",
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

                          // Container(
                          //   width: 66,
                          //   height: 55,
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 25.w),
                          //     child: Row(
                          //       children: [
                          //         const Text("Pipe Line Name"),
                          //         pipeLineNameTextFormField(),
                          //
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration From",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 30.w),
                                Text(
                                  "Duration To",
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
                                              child: SvgPicture.asset("assets/icons/Date_icon.svg", width: 30.w,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                                              child: SvgPicture.asset("assets/icons/Date_icon.svg", width: 30.w,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Time From",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 30.w),
                                Text(
                                  "Time To",
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                              child: SvgPicture.asset("assets/icons/Clock_icon.svg", width: 20.w,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                                              child: SvgPicture.asset("assets/icons/Clock_icon.svg", width: 20.w,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 250.w,
                                    height: 65.h,
                                    child: clientDropDowButtonFromField()
                                ),
                                // const Spacer(),
                                // SizedBox(
                                //     width: 150.w,
                                //     height: 65.h,
                                //     child: assignToDropDowButtonFromField()
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: descriptionTextFormField(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: "Add Next",
                                onPressed: (){
                                  print("this is name vale" + newSelectedClient!);
                                  _formKey.currentState!.save();
                                  if(_formKey.currentState!.validate() && newSelectedClient.isNotEmpty && fullName.isNotEmpty){
                                    CreateTaskInputs(
                                      clientName: newSelectedClient,
                                      assignToName: fullName,
                                      fromDate: fromDate!,
                                      toDate: toDate!,
                                      fromTime: fromTime!,
                                      toTime: toTime!,
                                      description: description!,
                                      client_phoneNumber: clientPhoneNumber,
                                      latitude: clientLocationLatitude ,
                                      longitude: clientLocationLongitude ,
                                      client_locationName: clientLocation ,
                                                                         employee_email: employee_email,
                                    ).createPipeLine(fullName , context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      content: Text(
                                        'This Pipe Line is Created',
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
                          // Padding(
                          //   padding: EdgeInsets.only(left: 15.w),
                          //   child: Text("Last Tasks :",
                          //     style: TextStyle(
                          //         color: Colors.black,
                          //         fontSize: 25.sp),
                          //   ),
                          // ),
                          // FutureBuilder(
                          //   future: pipeLineGetter,
                          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          //     if(snapshot.connectionState == ConnectionState.waiting){
                          //       return Center(
                          //         heightFactor: 50.h,
                          //         child: CircularProgressIndicator(
                          //           backgroundColor: Colors.white,
                          //           color: AppColors().defaultColor,
                          //         ),
                          //       );
                          //     } else if(snapshot.hasError){
                          //       return const Center(
                          //         child: Text("Error"),
                          //       );
                          //     } else {
                          //       if(snapshot.hasData){
                          //         print("pipe line Data = ${snapshot.data}");
                          //
                          //         return Padding(
                          //           padding: EdgeInsets.symmetric(horizontal: 25.w),
                          //           child: ListView.builder(
                          //             physics: const BouncingScrollPhysics(),
                          //             shrinkWrap: true,
                          //             itemCount:  snapshot.data.length,
                          //             itemBuilder: (BuildContext context, int index) {
                          //               return Padding(
                          //                 padding: EdgeInsets.symmetric(vertical: 10.h),
                          //                 child: GestureDetector(
                          //                     onTap: () {
                          //                       Navigator.push(context, MaterialPageRoute(
                          //                           builder: (BuildContext context) {
                          //                             return ViewTaskCollectScreen();
                          //                           }));
                          //                       onLongPress: () {
                          //                       };
                          //                      setState(() {
                          //                         enableCheckBox = true;
                          //                       });
                          //                     },
                          //                     child: CustomPipeLineListItem(enableCheckBox, index, snapshot.data,),
                          //                 ),
                          //               );
                          //             },),
                          //         );
                          //       } else {
                          //         return const Center(
                          //           child: Text("No data"),
                          //         );
                          //       }
                          //     }
                          //   },)
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
                    newSelectedClient = value!;
                    for(var thisclient in  clientList){
                      if(value == thisclient.name){
                        clientLocationLatitude = thisclient.latitude;
                        clientLocationLongitude = thisclient.longitude;
                        clientPhoneNumber = thisclient.phoneNumber;
                        clientLocation = thisclient.locationName;
                      }
                    }
print("locATION IS ${clientLocation}");
                    print("lat IS ${clientLocationLatitude}");
                    print("lng IS ${clientLocationLongitude}");
                    print(" IS ${clientLocation}");

                    print("number  IS ${clientPhoneNumber}");

                    setState(() {

                    });
                  },
                  selectedItem: newSelectedClient,
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

  Widget assignToDropDowButtonFromField(){
    List<String> employeesNames = [];
    List <String> PipeLineNames =  Provider.of<TaskOutputs>(context , listen: false).pepeLineNames;

List <String> OutPutPipeLineNames = [];
    for(var employee in assignToList){
      employeesNames.add(employee.first_name+ employee.last_name);
    }
    employeesNames.forEach((element) {
      if(PipeLineNames.contains(element) == false){
        OutPutPipeLineNames.add(element);
      }
    });
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
            items: OutPutPipeLineNames,

            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Select Employee",
                hintText: "Select Employee",
              ),
            ),
            onChanged: (value){

              fullName = value!;
              for(var employee in assignToList){
                if(employee.first_name+employee.last_name == fullName){
                  employee_email = employee.email;
                }
              }
setState(() {

});

            },
            selectedItem: fullName,
          ),
        ),





      ],
    );

  }

  Widget descriptionTextFormField(){
    return TextFormField(
      onSaved: (value){
        description = value;
      },
      validator: (value){
        if(value!.isEmpty){
          return "Please enter description";
        }
        return null;
      },
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
    );
  }
  // Widget pipeLineNameTextFormField(){
  //   return TextFormField(
  //     onSaved: (value){
  //       pipeLineName = value;
  //       setState(() {
  //         print("the name of pipeline is ${pipeLineName}");
  //       });
  //     },
  //     validator: (value){
  //       if(value!.isEmpty){
  //         return "Please enter PipeLine Name";
  //       }
  //       return null;
  //     },
  //     maxLines: 5,
  //     cursorColor: Colors.black,
  //     style: TextStyle(
  //       color: Colors.black,
  //       fontSize: 22.sp,
  //     ),
  //     decoration: InputDecoration(
  //       filled: true,
  //       fillColor: Colors.grey[200],
  //       hintText: "Add  Pipe Line Name",
  //       hintStyle: TextStyle(
  //         color: Colors.black45,
  //         fontSize: 22.sp,
  //         fontWeight: FontWeight.w600,
  //       ),
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
  //   );
  // }
}