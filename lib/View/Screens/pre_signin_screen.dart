import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/user_outputs.dart';
import 'package:royal_marketing/View/Accountant_Screens/main_page_acc.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/main_page_rep.dart';
import 'package:royal_marketing/View/Screens/login_screen.dart';

import '../../contants.dart';
import '../Widgets/custom_button.dart';
class PreloginScreen extends StatelessWidget {
   PreloginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;




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
                Center(
                  child: Text(
                    "Choose , Are You ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05,),
                Center(
                  child: CustomButton(
                      text: "Accountant",
                      onPressed: () async {
Provider.of<UserOutputs>(context , listen: false).userRole = "Accountant";
print(Provider.of<UserOutputs>(context , listen: false).userRole);
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginScreen()), (route) => false);


                      }),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),
                Center(
                  child: CustomButton(
                      text: "Rep Sales",
                      onPressed: () async {
                        Provider.of<UserOutputs>(context , listen: false).userRole = "Rep Sales";
print(Provider.of<UserOutputs>(context , listen: false).userRole);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginScreen()), (route) => false);

                      }),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),
                Center(
                  child: CustomButton(
                      text: "Admin",
                      onPressed: () async {
                        Provider.of<UserOutputs>(context , listen: false).userRole = "Admin";
                        print(Provider.of<UserOutputs>(context , listen: false).userRole);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginScreen()), (route) => false);

                      }),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),
                Center(
                  child: CustomButton(
                      text: "Supervisor",
                      onPressed: () async {
                        Provider.of<UserOutputs>(context , listen: false).userRole = "Supervisor";
                        print(Provider.of<UserOutputs>(context , listen: false).userRole);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginScreen()), (route) => false);

                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
