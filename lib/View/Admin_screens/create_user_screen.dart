import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/create_user_inputs.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';
import 'package:royal_marketing/View/Widgets/custom_text_form_field.dart';
import 'package:royal_marketing/View/Widgets/custom_text_form_field_pass.dart';

import '../../Controller/user_outputs.dart';
import '../../contants.dart';
import 'Map.dart';
import 'main_page_admin.dart';
import 'map_user.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? userType;
  String userRole = "";
  UserType? selectedUserType;
  UserRole? selectedUserRole;
  List<UserType> userTypeList = [UserType(userType: "Admin"), UserType(userType: "Client"), UserType(userType: "Employee")];
  List<UserRole> userRoleList = [UserRole(userRole: "Manager"), UserRole(userRole: "Represintive"), UserRole(userRole: "Supervisor")];
  String? phoneNumber;
  String? address;
  String email = "";
  String password = "";
  bool agreedOrNot = false;


  bool agreed = false;
bool isClient = false;
  TextEditingController _locationController  = TextEditingController();

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
                  SizedBox(width: 75.w,),
                  Text(
                    "Create User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
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
            SizedBox(height: 5.h,),
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
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 145.w,
                                  height: 55.h,
                                  child: namesTextFormField("First Name"),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 145.w,
                                  height: 55.h,
                                  child: namesTextFormField("Last Name"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 150.w,

                                  height: 55.h,
                                  child: userTypeDropDownButtonFormField(),
                                ),
                                // const Spacer(),
                                // SizedBox(
                                //   width: 145.w,
                                //   height: 55.h,
                                //   child: userRoleDropDownButtonFormField(),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child: CustomTextFormField(
                              validator: (value){
                                if(value.isEmpty){
                                  return "Please enter phone number";
                                }
                              },
                              onSave: (value){
                                phoneNumber = value;
                              },
                              hint: "Phone Number",
                              icon: "assets/icons/Phone_icon.svg",
                              iconColor: AppColors().defaultColor,
                              fontSize: 22.sp,
                            ),
                          ),
                          //Location
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child:   TextFormField(
                              validator: (value) {
                                if (Provider.of<UserOutputs>(context , listen: false).isLocationChecked == false) {
                                  return 'Please enter Location';
                                }
                                return null;
                              },
                              onTap: (){
                                Navigator.push(context , MaterialPageRoute( builder: (BuildContext context) =>
                                const MapUserScreen() ));
                              },


                              readOnly: true,
                              controller: _locationController,
                              decoration: InputDecoration(
                                suffixIcon: Provider.of<UserOutputs>(context , listen: true).isLocationChecked ?
                                Icon(CupertinoIcons.check_mark_circled_solid , color: Colors.green,) :
                                Icon(CupertinoIcons.check_mark_circled_solid , color: Colors.grey,)
                                ,
                                hintText: Provider.of<UserOutputs>(context , listen: true).locationName == "" ?  "Client Location (Tap To Edit)" :
                                Provider.of<UserOutputs>(context  , listen: true).locationName   ,
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
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                          //   child: TextFormField(
                          //     onSaved: (value) {
                          //       address = value;
                          //     },
                          //     validator: (value) {
                          //       if(value!.isEmpty){
                          //         return "Please enter address";
                          //       }
                          //       return null;
                          //     },
                          //     cursorColor: Colors.black,
                          //     style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 22.sp,
                          //     ),
                          //     decoration: InputDecoration(
                          //       filled: true,
                          //       fillColor: Colors.grey[200],
                          //       hintText: "Address",
                          //       hintStyle: TextStyle(
                          //         color: Colors.black45,
                          //         fontSize: 22.sp,
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //       prefixIcon: Padding(
                          //         padding: EdgeInsets.symmetric(horizontal: 15.w),
                          //         child: Icon(Icons.location_pin, color: AppColors().defaultColor, size: 25.w,),
                          //       ),
                          //       contentPadding: EdgeInsets.all(20.r),
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
                          //   ),
                          // ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child: CustomTextFormField(
                              onSave: (value){
                                email = value;
                              },
                              validator: (value){
                                if(isClient){
                                  return null;
                                } else {
                                  if (!(value.contains('@')) ||
                                      !(value.contains('.com')) ||
                                      value.isEmpty) {
                                    return "Please enter email";
                                  } else {
                                    return null;
                                  }
                                }

                              },
                              hint: "E-mail",
                              icon: "assets/icons/Email_icon.svg",
                              iconColor: AppColors().defaultColor,
                              fontSize: 22.sp,
                            ),
                          )  ,
                          isClient ? SizedBox() : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child: CustomTextFormFieldPass(
                              onSaved: (value){
                                password = value;
                              },
                              validator: (value){
                                if(isClient){
                                  return null;
                                } else {
                                  if (value.isEmpty) {
                                    return "Please Enter Password";
                                  } else {
                                    if (value.length < 8) {
                                      return "Must be at least 8 character";
                                    } else {
                                      return null;
                                    }
                                  }
                                }

                              },
                              hintText: "Password",
                              icon: "assets/icons/Password_icon.svg",
                              iconColor: AppColors().defaultColor,
                              fontSize: 22.sp,
                            ),
                          )  ,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.3.r,
                                  child: Checkbox(
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                      checkColor: Colors.white,
                                      activeColor: AppColors().defaultColor,
                                      value: agreed,
                                      onChanged: (value) {
                                        setState(() {
                                          agreed = value!;
                                          agreedOrNot = value;
                                        });
                                      }),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.0.h),
                                  child: SizedBox(
                                    width: 230.w,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        "You agree that this Client is avilable \nto Be Contacted",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
                            child: Center(
                              child: CustomButton(
                                text: 'Create',
                                onPressed: (){
                                  _formKey.currentState!.save();
                                  if(_formKey.currentState!.validate()){
                                    CreateUserInputs(
                                      isClient: isClient,
                                      firstName: firstName!,
                                      lastName: lastName!,
                                      userType: userType!,
                                      userRole: userRole ,
                                      phoneNumber: phoneNumber!,
                                      // address: address!,
                                      email: email,
                                      password: password,
                                      agreedOrNot: agreedOrNot,
                                    ).createUser(!isClient , context , email);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      content: Text(
                                        'The user is Created',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                                    isClient = false;
                                    _locationController.clear();
                                    Provider.of<UserOutputs>(context , listen: false).markLocationUnchecked();
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
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
                            child: Center(
                              child: SizedBox(
                                width: 400.w,
                                height: 70.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xffF5F7FE),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(25.r))),
                                  ),
                                  onPressed: () {

                                  },
                                  child: Text(
                                      "Import From Contacts",
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
            ),
          ],
        ),
      ),
    );
  }
  
  Widget namesTextFormField(String hint){
    return TextFormField(
      onSaved: (value) {
        if(hint == "First Name"){
          firstName = value;
        }
        if(hint == "Last Name"){
          lastName = value;
        }
      },
      validator: (value) {
        if(value!.isEmpty){
          return "Please enter name";
        }
        return null;
      },
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.black45,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
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

  Widget userTypeDropDownButtonFormField(){
    return Stack(
      children: [
        DropdownButtonFormField<UserType>(
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: "User Type",
            hintStyle: TextStyle(
              color: Colors.black45,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
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
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors().defaultColor, size: 25.w,),
          validator: (value){
            if (value == null) {
              return "Please enter user type";
            }
            return null;
          },
          onSaved: (value){
            userType = value!.userType;
          },
          value: selectedUserType,
          onChanged: (UserType? value) {
            setState(() {
              selectedUserType = value;
              userType = value!.userType;
              print(userType);
              print("this is value ${value.userType.toString()}");
              if(value.userType.toString() == "Client" ){
                userRoleList = [UserRole(userRole: "Client")];
                isClient = true;
                setState(() {
                  
                });
              } else {
                userRoleList.clear();
             userRoleList = [UserRole(userRole: "Manager"), UserRole(userRole: "Represintive"), UserRole(userRole: "Supervisor")];

                isClient = false;
                setState(() {

                });
              }
            });
          },
          items: userTypeList.map((UserType user) {
            return DropdownMenuItem<UserType>(
              value: user,
              child: Text(
                user.userType,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget userRoleDropDownButtonFormField(){
    return Stack(
      // children: [
      //   DropdownButtonFormField<UserRole>(
      //     isExpanded: true,
      //     decoration: InputDecoration(
      //       filled: true,
      //       fillColor: Colors.grey[200],
      //       hintText: "User Role",
      //       hintStyle: TextStyle(
      //         color: Colors.black45,
      //         fontSize: 20.sp,
      //         fontWeight: FontWeight.w600,
      //       ),
      //       contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
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
      //     icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors().defaultColor, size: 25.w,),
      //     validator: (value){
      //       if (value == null) {
      //         return "Please enter user role";
      //       }
      //       return null;
      //     },
      //     onSaved: (value){
      //       userRole = value!.userRole;
      //     },
      //     value: selectedUserRole,
      //     onChanged: (value) {
      //       setState(() {
      //         selectedUserRole = value;
      //         userRole = value!.userRole;
      //         print(userRole);
      //       });
      //     },
      //     items: userRoleList.map((UserRole? user) {
      //       return DropdownMenuItem<UserRole>(
      //         value: user,
      //         child: Text(
      //           user!.userRole,
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 20.sp,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       );
      //     }).toList(),
      //   ),
      // ],
    );
  }
}

class UserType {
  String userType;

  UserType({required this.userType});
}

class UserRole {
  String userRole;

  UserRole({
    required this.userRole,
  });
}
