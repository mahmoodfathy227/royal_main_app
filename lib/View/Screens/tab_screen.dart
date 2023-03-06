import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_marketing/View/Screens/onboarding_business_screen.dart';

import '../Widgets/custom_on_boarding_button.dart';
import 'on_boarding_team_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final _totalDots = 2;
  double _currentPosition = 0.0;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _totalDots);

    _tabController.addListener(() {
      int selectedIndex = 0;
      setState(() {
        selectedIndex = _tabController.index;
        _currentPosition = selectedIndex + 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.r, right: 5.r, left: 5.r, bottom: 5.r),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: TabBarView(
                  controller: _tabController,
                  children: const [OnBoardingBusinessScreen(), OnBoardingTeamScreen()],
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            DotsIndicator(
              dotsCount: _totalDots,
              position: _currentPosition,
              decorator: DotsDecorator(
                activeColor: Colors.red,
                size: Size.square(9.w),
                activeSize: Size(25.w, 9.h),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: const CustomOnBoardingButton(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}