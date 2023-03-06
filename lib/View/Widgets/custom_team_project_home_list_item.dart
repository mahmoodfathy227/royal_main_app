import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:royal_marketing/View/Widgets/TeamViewer.dart';

import '../../contants.dart';
import 'main_page.dart';

class CustomTeamProjectHomeListItem extends StatefulWidget {
   CustomTeamProjectHomeListItem({Key? key, required this.index, this.data}) : super(key: key);
  final int index;
  final  data;

  @override
  State<CustomTeamProjectHomeListItem> createState() => _CustomTeamProjectHomeListItemState();
}

class _CustomTeamProjectHomeListItemState extends State<CustomTeamProjectHomeListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return TeamViewer(
            teamCount: widget.data[widget.index].team_count,
            teamMembers: widget.data[widget.index].member_data,
            teamName: widget.data[widget.index].team_name,
            teamSupervisor: widget.data[widget.index].supervisor_name ,
          );
        }));
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Container(
          width: double.infinity,
          height: 140.h,
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team ${widget.data[widget.index].team_name} Project",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/Date_project_team_icon.svg", width: 25.w,),
                          const SizedBox(width: 5,),
                          Text(
                            widget.data[widget.index].supervisor_name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.more_vert, color: Colors.black, size: 25.w,))
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    width: 230.w,
                    lineHeight: 10.h,
                    percent: 0.8,
                    backgroundColor: Colors.grey[400],
                    progressColor: AppColors().defaultColor,
                  ),
                  const Spacer(),
                  Text(
                    "..%",
                    style: TextStyle(
                      color: AppColors().defaultColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.watch_later_outlined, color: Colors.black, size: 25.w,),
                  SizedBox(width: 10.w,),
                  Container(
                    width: 160.w,
                    child: Text(
                      widget.data[widget.index].member_data,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "+ ${widget.data[widget.index].team_count}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: Image.asset("assets/images/Person_image.png", width: 25.w,),
                          ),
                        ),
                        Positioned(
                          left: 16.w,
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[200],
                              child: Image.asset("assets/images/Person_image.png", width: 25.w,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
