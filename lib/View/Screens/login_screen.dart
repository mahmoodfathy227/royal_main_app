import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/Controller/user_outputs.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/main_page_rep.dart';
import 'package:royal_marketing/View/Screens/password_recovery_screen.dart';
import 'package:royal_marketing/View/Screens/register_screen.dart';
import 'package:royal_marketing/View/Widgets/custom_button.dart';
import 'package:royal_marketing/contants.dart';

import '../../Controller/Auth/email.dart';
import '../Accountant_Screens/main_page_acc.dart';
import '../Admin_screens/main_page_admin.dart';
import '../Widgets/custom_text_form_field.dart';
import '../Widgets/custom_text_form_field_pass.dart';

class LoginScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;

  LoginScreen({Key? key}) : super(key: key);

TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.2,),
                Text(
                  "Hi, Welcome Back!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01,),
                Text(
                  "Sign in to your account.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05,),
            Container(
              child: Column(
                children: [
                  TextFormField(

                    controller: emailController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SvgPicture.asset("assets/icons/Password_icon.svg" ,width: 22.w),
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
                  )
                ],
              ),
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
                SizedBox(height: SizeConfig.screenHeight * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return PasswordRecoveryScreen();
                          }));
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors().defaultColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),)),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05,),
                Center(
                  child: CustomButton(
                      text: "Login",
                      onPressed: () async {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          try {

String email = emailController.text.replaceAll(" ", "");
print("this is email ${email}");
Provider.of<TeamOutputs>(context , listen: false).assignSupervisorEmail(email);

                            await EmailUser()
                                .signIn(email, password.toString() , context)
                                .then((value) async {

if(EmailUser().cred != null){

} else {

}








                            });
                          } catch (e) {
                            print(e.toString());
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
                SizedBox(height: SizeConfig.screenHeight * 0.2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account ?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return RegisterScreen();
                        }));
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: AppColors().defaultColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
