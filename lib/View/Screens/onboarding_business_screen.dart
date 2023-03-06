import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OnBoardingBusinessScreen extends StatefulWidget {
  const OnBoardingBusinessScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingBusinessScreen> createState() => _OnBoardingBusinessScreenState();
}

class _OnBoardingBusinessScreenState extends State<OnBoardingBusinessScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/Manage_business.png",
              height: MediaQuery.of(context).size.height / 4,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 10.h,),
          Text(
            "Business",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h,),
          Text("Manage \nyour \nBusiness",
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
