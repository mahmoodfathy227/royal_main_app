import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:royal_marketing/View/Accountant_Screens/view_screen.dart';
import 'package:royal_marketing/View/Admin_screens/calender_screen.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/profile_screen.dart';
import 'package:royal_marketing/View/Screens/chat_screen.dart';
import 'package:royal_marketing/View/Admin_screens/create_pipe_line_screen.dart';
import 'package:royal_marketing/View/Admin_screens/create_team_screen.dart';
import 'package:royal_marketing/View/Admin_screens/create_user_screen.dart';
import 'package:royal_marketing/contants.dart';
import 'calender_screen.dart';
import 'home_screen_rep.dart';

class MainPageRep extends StatefulWidget{

  int selectedItemPosition = 0;

  MainPageRep({Key? key,
    required this.selectedItemPosition
  }) : super(key: key);

  @override
  State<MainPageRep> createState() => _MainPageState();

}

class _MainPageState extends State<MainPageRep>{

  List<bool> iconsActivate = List.filled(4, false);
  final List<Widget> pageList = <Widget>[const HomeScreenRep(),  const ChatScreen(), const CalenderRepScreen(), const ProfileScreen() ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.selectedItemPosition,
        children: pageList,
      ),
      bottomNavigationBar: Container(
        color: const Color(0xffF9F9F9),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
        child: Card(
          elevation: 5,
          child: SnakeNavigationBar.color(
            height: 50.h,
            elevation: 0,
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
            shape: const RoundedRectangleBorder(),
            padding: EdgeInsets.only(bottom: 0.r, left: 0.r, right: 0.r,top: 5.r),


            snakeViewColor: AppColors().defaultColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blueGrey,

            showUnselectedLabels: false,
            showSelectedLabels: false,

            currentIndex: widget.selectedItemPosition,
            onTap: (index) => setState(() => widget.selectedItemPosition = index),
            items: [
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: SvgPicture.asset("assets/icons/Home_icon.svg", color: Colors.white ,width: 25.w),
                  ),
                  label: 'Home',
                  icon: SvgPicture.asset("assets/icons/Home_icon.svg", width: 25.w)),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: SvgPicture.asset("assets/icons/Chat_icon.svg", color: Colors.white ,width: 30.w),
                  ),
              label: 'Chat',
              icon: SvgPicture.asset("assets/icons/Chat_icon.svg", width: 30.w)),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: SvgPicture.asset("assets/icons/Chat_icon.svg", color: Colors.white ,width: 30.w),
                  ),
                  label: 'Calender',
                  icon: SvgPicture.asset("assets/icons/Calendar_icon.svg", width: 30.w)),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: SvgPicture.asset("assets/icons/Contacts_icon.svg", color: Colors.white ,width: 23.w),
                  ),
                  label: 'Chat',
                  icon: SvgPicture.asset("assets/icons/Contacts_icon.svg", width: 23.w)),
            ],
          ),
        ),
      ),


    );
  }

  CustomBottomSheet(BuildContext context){
    return Scaffold.of(context).showBottomSheet(
      (context) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Container(
          height: 200.h,
          color: Colors.grey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}