import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingTeamScreen extends StatefulWidget {
  const OnBoardingTeamScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingTeamScreen> createState() => _OnBoardingTeamScreenState();
}

class _OnBoardingTeamScreenState extends State<OnBoardingTeamScreen> {
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
              "assets/images/Manage_team.png",
              height: MediaQuery.of(context).size.height / 4,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 20.h,),
          Text(
            "Team",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h,),
          Text("Manage \nyour Team \nAnywhere",
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
