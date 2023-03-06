import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:royal_marketing/View/Admin_screens/profile_admin_screen.dart';
import 'package:royal_marketing/View/Screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../contants.dart';
import '../Supervisor_screens/profile_supervisor_screen.dart';

class ImageProfileAndNotification{
  String? tag;
  List<Widget> imageProfileAndNotificationWithPoint(BuildContext context){
    return [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SvgPicture.asset("assets/icons/Notification_icon.svg", width: 20.w,),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
        child: SizedBox(
          width: 60.w,
          height: 60.h,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors().defaultColor,
            child: IconButton(
                onPressed: () async{
                  await getCurrentUser();
                  print("This is tag ${tag}");

                  switch(tag) {
                    case "admin":
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>  ProfileAdminScreen()));
                      break;
                  // case "Sales":
                  //   print('one!');
                  //   break;
                  // case 2:
                  //   print('two!');
                  //   break;
                    default:
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen()));
                  }
                },
                icon: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ];
  }
  List<Widget> imageProfileAndNotificationWithPointSupervisor(BuildContext context){
    return [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SvgPicture.asset("assets/icons/Notification_icon.svg", width: 20.w,),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
        child: SizedBox(
          width: 60.w,
          height: 60.h,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors().defaultColor,
            child: IconButton(
              onPressed: () async{
                await getCurrentUser();
                print("This is tag ${tag}");

                Navigator.push(context, MaterialPageRoute(builder: (_)=>  SupervisorProfileScreen()));
              },
              icon: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ];
  }
  Future<String?> getCurrentUser() async{
    final prefs = await SharedPreferences.getInstance();
 tag =   prefs.getString('loginTag')!;
    return tag;
  }
}