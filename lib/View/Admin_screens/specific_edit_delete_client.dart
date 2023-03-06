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

import '../../Controller/create_task_inputs.dart';
import '../../Controller/task_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_delete_dialog.dart';
import '../Widgets/custom_pipe_line_list_item.dart';
import 'main_page_admin.dart';

class SpecificEditDeleteClientScreen extends StatefulWidget {
  const SpecificEditDeleteClientScreen({Key? key, required this.comingName, required this.comingEmail, required this.cominglat, required this.cominglng, required this.comingPhoneNumber}) : super(key: key);
final String comingName;
  final String comingEmail;
  final double cominglat;
  final double cominglng;
  final String comingPhoneNumber;

  @override
  State<SpecificEditDeleteClientScreen> createState() => _CreatePipeLineScreenState();
}

class _CreatePipeLineScreenState extends State<SpecificEditDeleteClientScreen> {

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
  String? selectedClient;
  UserModel? selectedAssignTo;
  List<ClientModel> clientList = <ClientModel>[];
  List<UserModel> assignToList = <UserModel>[];
  late Future<List<dynamic>> user;
  late Future<List<dynamic>> client;
  late Future<List<dynamic>> task;
  // late Future<List<dynamic>> pipeLineGetter;
  Future? taskAndUser;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  TextEditingController clientLocationLat = TextEditingController();
  TextEditingController clientLocationLng = TextEditingController();
  TextEditingController clientLocationPhoneNumber = TextEditingController();

  String client_name = "";
  String client_email = "";
  String client_Phone_Number = "";
  String phone_number = "";
  double client_lat = 0.0;
  double client_lng = 0.0;


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
clientNameController.text = widget.comingName;
 clientEmailController.text = widget.comingEmail;
 clientLocationLat.text = widget.cominglat.toString();
clientLocationLng.text = widget.cominglng.toString();
 clientLocationPhoneNumber.text = widget.comingPhoneNumber;
    client = Provider.of<UserOutputs>(context, listen: false).getClients();
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
                    "Edit Client",
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
                                  Text("Choose Client",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),

                                  ),
                                  SizedBox(height: 15,),

                                ],),
                            ),
                          ),

                          // Name
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Client Name",
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
                              controller: clientNameController,
                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                client_name = value;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter Client Name";
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
                          //email
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Client email",
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
                              controller: clientEmailController,
                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                client_email = value;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter Client Email";
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
                          //location lat
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Client location lat",
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
                              controller: clientLocationLat,
                              onChanged: (value){
                                client_lat = double.parse(value);

                              },
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
                          //location lng
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Client location lng",
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
                              controller: clientLocationLng,

                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                client_lng = double.parse(value);

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
                                  "Client Phone Number",
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
                              controller: clientLocationPhoneNumber,
                              onSaved: (value){
                                description = value;
                              },
                              onChanged: (value){
                                client_Phone_Number = value;
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
                                hintText: "Client Phone Number",
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
                          //update
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: "Update",
                                onPressed: (){
                                  _formKey.currentState!.save();
                                  if(_formKey.currentState!.validate()){
                                    if(client_name.isEmpty){
                                      client_name = clientNameController.text;
                                    }
                                    if(client_email.isEmpty){
                                      client_email = clientEmailController.text;
                                    }
                                    if(phone_number.isEmpty){
                                      phone_number = clientLocationPhoneNumber.text;
                                    }
                                    if(client_lat == 0.0 ){
                                      client_lat = double.parse(clientLocationLat.text.toString());
                                    }
                                    if(client_lng == 0.0){
                                      client_lng = double.parse(clientLocationLng.text.toString());

                                    }
                                    Provider.of<UserOutputs>(context, listen: false).updateClient(
                                        email: clientEmailController.text,

                                        phoneNumber: phone_number,
                                        name: client_name,
                                        locationLat: client_lat,
                                        locationLng: client_lng

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

                                    var gottenDoc =  await FirebaseFirestore.instance.collection("Clients").
                                    where("email" , isEqualTo:clientEmailController.text ).get();

                                    DocumentReference docReference = gottenDoc.docs[0].reference;
                                    await FirebaseFirestore.instance.collection("Clients").
                                    doc(docReference.id).delete().then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Colors.deepPurpleAccent,
                                        content: Text(
                                          'This Client is Deleted',
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













}