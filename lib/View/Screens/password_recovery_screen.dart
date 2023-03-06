import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_marketing/View/Screens/verify_your_identity_screen.dart';

import '../../contants.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_form_field.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  //const PasswordRecoveryScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;


  void sendOtp(BuildContext context) async {
    EmailAuth emailAuth =  EmailAuth(sessionName: "Royal");
    bool result = await emailAuth.sendOtp(recipientMail: email!);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey,
        content: Text("The code is sent to your email",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp),
          textAlign: TextAlign.center,),
        duration: const Duration(seconds: 2),
      ));
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return VerifyYourIdentity(email: email!);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Password Recovery",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Enter your E-mail to recover \nyour password",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25,),
              CustomTextFormField(
                hint: "Email",
                fontSize: 22.sp,
                onSave: (value) {
                  email = value;
                },
                icon: "assets/icons/Email_icon.svg",
                iconColor: AppColors().defaultColor,
                validator: (value) {
                  if (!(value.contains('@')) ||
                      !(value.contains('.com')) ||
                      value.isEmpty) {
                    return "Please Enter Email";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 150.h,),
              CustomButton(
                text: "Continue",
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    sendOtp(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
