import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:royal_marketing/View/Screens/password_recovery_screen.dart';
import 'package:royal_marketing/View/Screens/reset_your_password_screen.dart';

import '../../contants.dart';
import '../Widgets/custom_button.dart';

class VerifyYourIdentity extends StatefulWidget {

  String email;

  VerifyYourIdentity({
    required this.email,
  });

  @override
  State<VerifyYourIdentity> createState() => _VerifyYourIdentityState();

}

class _VerifyYourIdentityState extends State<VerifyYourIdentity> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String currentText = "";
  String? code;

  bool verify() {
    return EmailAuth(sessionName: "Royal").validateOtp(
        recipientMail: widget.email,
        userOtp: code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, bottom: 50),
                child: Text(
                  "Verify your identity",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "We have just send a code to",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.email,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: PinCodeTextField(
                    length: 6,
                    enableActiveFill: true,
                    cursorColor: Colors.black,
                    cursorHeight: 25.h,
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.sp,
                    ),
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 200),
                    validator: (v) {
                      if (v!.length < 6) {
                        return "Please Enter 6 Digits Code";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      code = v!;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50.h,
                      fieldWidth: 50.w,
                      activeColor: Colors.grey.shade200,
                      selectedColor: Colors.grey.shade200,
                      inactiveColor: Colors.grey.shade200,
                      selectedFillColor: Colors.grey.shade200,
                      activeFillColor: Colors.grey.shade200,
                      inactiveFillColor: Colors.grey.shade200,
                    ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                      appContext: context),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Continue",
                onPressed: () {
                  _formKey.currentState!.save();
                  if(_formKey.currentState!.validate()){
                    verify();
                    if(verify()){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.grey,
                        content: Text("The code is correct",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp),
                          textAlign: TextAlign.center,),
                      ));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ResetYourPasswordScreen();
                          }));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.grey,
                        content: Text("Wrong code please check your email again",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp),
                          textAlign: TextAlign.center,),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  }
                }
              ),
              SizedBox(height: 150.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive Code ?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      PasswordRecoveryScreen().sendOtp(context);
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: AppColors().defaultColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Not You?",
                  style: TextStyle(
                    color: AppColors().defaultColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
