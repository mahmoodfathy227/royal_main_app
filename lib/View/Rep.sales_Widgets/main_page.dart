import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/chat_screen.dart' as prefix_chat;
import 'package:royal_marketing/View/Rep.sales_Screens/calender_screen.dart' as prefix_calender;
import 'package:royal_marketing/View/Rep.sales_Screens/profile_screen.dart' as prefix_profile;
import 'package:royal_marketing/View/Rep.sales_Screens/home_screen_rep.dart' as prefix_home;
import 'package:royal_marketing/contants.dart';


class MainPage extends StatefulWidget{
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage>{

  List<bool> iconsActivate = List.filled(4, false);

  int _selectedItemPosition = 0;
  final List<Widget> pageList = <Widget>[prefix_home.HomeScreenRep(), const prefix_chat.ChatScreen(), const prefix_calender.CalenderRepScreen(), const prefix_profile.ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedItemPosition,
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
            padding: EdgeInsets.only(bottom: 0.r, left: 10.r, right: 10.r,top: 5.r),

            ///configuration for SnakeNavigationBar.color
            snakeViewColor: AppColors().defaultColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blueGrey,

            showUnselectedLabels: false,
            showSelectedLabels: false,

            currentIndex: _selectedItemPosition,
            onTap: (index) => setState(() => _selectedItemPosition = index),
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
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset("assets/icons/Calendar_icon.svg", color: Colors.white ,width: 23.w),
                  ),
                  label: 'Calender',
                  icon: SvgPicture.asset("assets/icons/Calendar_icon.svg", width: 23.w)),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: SvgPicture.asset("assets/icons/Contacts_icon.svg", color: Colors.white ,width: 23.w),
                  ),
                  label: 'Profile',
                  icon: SvgPicture.asset("assets/icons/Contacts_icon.svg", width: 23.w)),
            ],
          ),
        ),
      ),
    );
  }
}
