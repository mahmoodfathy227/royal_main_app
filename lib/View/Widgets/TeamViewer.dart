import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Model/test_task_model.dart';

import '../../Controller/team_outputs.dart';
import '../../Model/task_model.dart';
import '../../contants.dart';
import '../Rep.sales_Screens/view_task_collection.dart';
import 'custom_pipe_line_group.dart';
import 'image_profile_and_notification.dart';

class TeamViewer extends StatefulWidget {


final String teamName;
final String teamCount;
final String teamMembers;
final String teamSupervisor;

  TeamViewer(  {Key? key, required this.teamName, required this.teamCount, required this.teamMembers, required this.teamSupervisor}) : super(key: key);

  @override
  State<TeamViewer> createState() => _CustomPipeLineListItemState();
}

class _CustomPipeLineListItemState extends State<TeamViewer> {



  @override
  void initState() {
    Provider.of<TeamOutputs>(context, listen: false).getCustomTeamData(widget.teamName);
    super.initState();
  }
  Widget build(BuildContext context) {
    print(widget.teamName.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().defaultColor,
        centerTitle: true,
        toolbarHeight: 60.h,
        title: Text(
          "Team",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: ImageProfileAndNotification().imageProfileAndNotificationWithPoint(context),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25))),
      ),
      body:  ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Team Pipe lines",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.h,),
                Provider.of<TeamOutputs>(context ).supervisorLoading == true ?
                const Center(
                  child: CircularProgressIndicator(),
                )

                    :
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:  Provider.of<TeamOutputs>(context , listen: false).finalMembersList.length,
                  itemBuilder: (BuildContext context, int index) {

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: GestureDetector(

                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {


                                  return ViewTaskCollection(
                                      pipeLineName: Provider.of<TeamOutputs>(context , listen: false).finalMembersList[index]
                                  );
                                }));
                            onLongPress: () {
                            };

                          },
                          child: CustomPipeLineGroup(
                            pipeLineName: Provider.of<TeamOutputs>(context , listen: false).finalMembersList[index],
                            tasksNumber: Provider.of<TeamOutputs>(context , listen: false).tasksCountTeam[index].toString(),
                            doneTasks: Provider.of<TeamOutputs>(context , listen: false).doneTasksTeamList[index] ,

                          )
                      ),
                    );
                  },)








                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       width: 50.w,
                //       height: 50.h,
                //       child: CircleAvatar(
                //         radius: 30,
                //         backgroundColor: Colors.grey[200],
                //         child: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover,),
                //       ),
                //     ),
                //     SizedBox(width: 6.w,),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Team Name : ${widget.teamName}",
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 20.sp,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //
                //       ],
                //     ),
                //     const Spacer(),
                //     SvgPicture.asset("assets/icons/note_icon.svg", width: 17.w, color: AppColors().defaultColor,),
                //
                //   ],
                // ),
                // SizedBox(height: 25.h,),
                // Row(
                //   children: [
                //     SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                //     SizedBox(width: 12.w,),
                //     Text(
                //       "Team Supervisor : ${widget.teamSupervisor}",
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 18.sp,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 25.h,),
                // Row(
                //   children: [
                //     SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                //     SizedBox(width: 12.w,),
                //     Text(
                //       "Team count : ${widget.teamCount}",
                //       style: TextStyle(
                //         color: AppColors().defaultColor,
                //         fontSize: 18.sp,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 25.h,),
                //
                //
                //
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     SvgPicture.asset("assets/icons/Clock_icon.svg", width: 23.w,),
                //     SizedBox(width: 12.w,),
                //     Container(
                //       width: 250,
                //
                //       child: Text(
                //         "Team Members : ${widget.teamMembers}",
                //         overflow: TextOverflow.clip,
                //
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 25.w,),
                //
                //     SizedBox(width: 12.w,),
                //
                //   ],
                // ),

              ],
            ),
          ),
        ),
      ),
    );


  }
}
