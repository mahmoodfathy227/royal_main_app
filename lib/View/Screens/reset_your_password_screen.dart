import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_marketing/Controller/Auth/email.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_form_field_pass.dart';

class ResetYourPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String? password;

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
                "Reset your password",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "At least 8 characters, with \nuppercase and lowercase letters",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              CustomTextFormFieldPass(
                hintText: "New Password",
                icon: "assets/icons/Password_icon.svg",
                fontSize: 22.sp,
                iconColor: Colors.grey,
                controller: _pass,
                onSaved: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 8) {
                    return "Please enter your new password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              CustomTextFormFieldPass(
                hintText: "Confirm Password",
                icon: "assets/icons/Password_icon.svg",
                fontSize: 22.sp,
                iconColor: Colors.grey,
                controller: _confirmPass,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Empty';
                  }
                  if(value != _pass.text) {
                    return 'Not Match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 70.h,),
              CustomButton(
                text: "Continue",
                onPressed: (){
                  _formKey.currentState!.save();
                  if(_formKey.currentState!.validate()){
                    EmailUser().changePassword(password!).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.grey,
                              content: Text(
                                'Password changed successfully',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp),
                                textAlign: TextAlign.center,
                              )));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'login_screen', (route) => false);
                    });
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
