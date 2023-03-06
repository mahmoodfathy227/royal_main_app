import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:royal_marketing/View/Accountant_Widgets/custom_group_chat_list_item.dart' as Accountant;
import 'package:royal_marketing/View/Widgets/custom_direct_message_list_item.dart';
import 'package:royal_marketing/View/Widgets/custom_text_form_field.dart';

import '../../contants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors().defaultColor,
        centerTitle: true,
        toolbarHeight: 60.h,
        title: Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/Setting_icon.svg",width: 25.w,),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: SvgPicture.asset("assets/icons/Notification_icon.svg", width: 25.w,),
          ),
        ],
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25))),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 8.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                hint: "Search",
                fontSize: 22.sp,
                icon: "assets/icons/Search_icon.svg",
                iconColor: Colors.black45,
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    "Group Chat",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const CircleBorder(),
                    minimumSize: Size(30.w, 30.h),
                  ),
                  child: Icon(Icons.add_rounded, color: Colors.white, size: 25.w,),
                ),
              ],
            ),
            Container(
              height: 200.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: const Accountant.CustomGroupChatListItem(),
                  );
                },
              ),
            ),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    "Direct Message",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const CircleBorder(),
                    minimumSize: Size(30.w, 30.h),
                  ),
                  child: Icon(Icons.add_rounded, color: Colors.white, size: 25.w,),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 10.r),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const CustomDirectMessageListItem(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
