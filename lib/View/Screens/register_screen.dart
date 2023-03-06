import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Controller/Auth/email.dart';
import '../../contants.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_form_field.dart';
import '../Widgets/custom_text_form_field_pass.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create your account.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05,),
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
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
              CustomTextFormFieldPass(
                hintText: "Password",
                icon: "assets/icons/Password_icon.svg",
                fontSize: 22.sp,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Password";
                  } else {
                    if (value.length < 8) {
                      return "Must be at least 8 character";
                    } else {
                      return null;
                    }
                  }
                },
                onSaved: (value) {
                  password = value;
                },
                obscureText: true,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05,),
              Center(
                child: CustomButton(
                    text: "Create",
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        try {
                          await EmailUser()
                              .register(email!, password!)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.grey,
                                    content: Text(
                                      'Account is created',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.center,
                                    )));
                            Navigator.pop(context);
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.grey,
                                  content: Text(
                                    'Invalid Email or Password',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp),
                                    textAlign: TextAlign.center,
                                  )));
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
