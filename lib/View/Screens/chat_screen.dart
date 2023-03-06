import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/View/Widgets/custom_direct_message_list_item.dart';
import 'package:royal_marketing/View/Widgets/custom_group_chat_list_item.dart';
import 'package:royal_marketing/View/Widgets/custom_text_form_field.dart';

import '../../Controller/team_outputs.dart';
import '../../Model/team_model.dart';
import '../../contants.dart';
import '../Widgets/image_profile_and_notification.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  var team;
getAll()async{
  await Provider.of<TeamOutputs>(context).getTeams();
}
  @override
  void initState() {
    // TODO: implement initState
    // getAll();
    super.initState();

    team = Provider.of<TeamOutputs>(context, listen: false);
  }


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
        actions: ImageProfileAndNotification().imageProfileAndNotificationWithPoint(context),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25))),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
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
            SizedBox(height: 8.h,),
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
            // Container(
            //   height: 250.h,
            //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            //   child: FutureBuilder(
            //     future: team.getTeams(),
            //     builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            //
            //       print(snapshot.connectionState);
            //       if(snapshot.connectionState == ConnectionState.waiting){
            //         return Center(
            //           heightFactor: 50.h,
            //           child: CircularProgressIndicator(
            //             backgroundColor: Colors.white,
            //             color: AppColors().defaultColor,
            //           ),
            //         );
            //       } else if(snapshot.hasError){
            //         return const Center(
            //           child: Text("Error"),
            //         );
            //       } else {
            //         if(snapshot.hasData){
            //           return ListView.builder(
            //             itemCount: snapshot.data?.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return Padding(
            //                 padding: EdgeInsets.symmetric(vertical: 8.h),
            //                 child: CustomGroupChatListItem(index, snapshot.data , 0),
            //               );
            //             },
            //           );
            //         } else {
            //           return const Center(
            //             child: Text("No data"),
            //           );
            //         }
            //       }
            //     },
            //   ),
            // ),
            SizedBox(height: 5.h,),
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
                padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h),
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
