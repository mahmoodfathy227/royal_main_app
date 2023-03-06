import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:royal_marketing/View/Admin_screens/calender_screen.dart';
import 'package:royal_marketing/View/Admin_screens/edit_rep_sales_screen.dart';
import 'package:royal_marketing/View/Screens/chat_screen.dart';
import 'package:royal_marketing/View/Admin_screens/create_pipe_line_screen.dart';
import 'package:royal_marketing/View/Admin_screens/create_team_screen.dart';
import 'package:royal_marketing/View/Admin_screens/create_user_screen.dart';
import 'package:royal_marketing/contants.dart';

import '../Admin_screens/contacts_screen.dart';
import 'create_supervisor_screen.dart';
import 'create_task_screen.dart';
import 'delete_supervisor_screen.dart';
import 'edit_client_screen.dart';
import 'home_screen_admin.dart';

class MainPageAdmin extends StatefulWidget{

  int selectedItemPosition;

  MainPageAdmin({Key? key,
    required this.selectedItemPosition
  }) : super(key: key);

  @override
  State<MainPageAdmin> createState() => _MainPageState();

}

class _MainPageState extends State<MainPageAdmin>{

  List<bool> iconsActivate = List.filled(4, false);
  final List<Widget> pageList = <Widget>[HomeScreenAdmin(), const ChatScreen(), const CalenderScreen(), const ContactsScreen()];


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
            padding: EdgeInsets.only(bottom: 0.r, left: 70.r, right: 0.r,top: 5.r),


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
                  label: 'Contacts',
                  icon: SvgPicture.asset("assets/icons/Contacts_icon.svg", width: 23.w)),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 57.w,
        height: 57.h,
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  backgroundColor: Colors.white,
                  builder: (builder){
                    return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.1,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 25.w,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return  CreateTaskScreen(searchedValue: null ,);
                                }));
                              },
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  "assets/icons/Create_task_icon.svg",
                                  width: 45.w,
                                ),
                                title: Text(
                                  "Add Task",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const CreateUserScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().defaultColor,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30.w,
                                    )),
                                title: Text(
                                  "Create User",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const CreateTeamScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().defaultColor,
                                    ),
                                    child: Icon(
                                      Icons.group,
                                      color: Colors.white,
                                      size: 30.w,
                                    ),
                                ),
                                title: Text(
                                  "Create Team",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const CreatePipeLineScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors().defaultColor,
                                  ),
                                  child: const Icon(Icons.timeline_rounded, color: Colors.white, size: 30,),
                                ),
                                title: Text(
                                  "Create Pipe Line",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const CreateSupervisorScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().defaultColor,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30.w,
                                    )),
                                title: Text(
                                  "Create Supervisor",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const EditRepSalesScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().defaultColor,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30.w,
                                    )),
                                title: Text(
                                  "Edit/Delete Rep Sales",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const EditClientScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().defaultColor,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30.w,
                                    )),
                                title: Text(
                                  "Edit/Delete Client",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20.w,
                              endIndent: 20.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return const DeleteSupervisorScreen();
                                }));
                              },
                              child: ListTile(
                                leading: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().defaultColor,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30.w,
                                    )),
                                title: Text(
                                  "Delete Supervisor",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
            },
            child: Icon(Icons.add_rounded, color: Colors.white,size: 45.w,),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
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