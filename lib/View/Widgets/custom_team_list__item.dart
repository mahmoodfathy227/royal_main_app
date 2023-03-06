import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/create_team_inputs.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/Model/team_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../contants.dart';

class CustomTeamListItem extends StatefulWidget{
  int index;
  var data;

  CustomTeamListItem(this.index, this.data);

  @override
  State<CustomTeamListItem> createState() => _CustomTeamListItemState();
}

class _CustomTeamListItemState extends State<CustomTeamListItem> {

  List<MemberOfTeam> membersOfTeamList = [];
bool isButtonDisabled = false;
  getId(int id) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('buttonId', id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
            width: 50.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Image.asset(
                "assets/images/Person_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data[widget.index].first_name + " " + widget.data[widget.index].last_name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.data[widget.index].phone_number,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(

            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: const Color(0xffF5F7FE),
            ),

            onPressed: () {
              if(isButtonDisabled == false){
                Provider.of<TeamOutputs>(context , listen: false).addTeamMembers(
                    MemberOfTeam(
                        memberName: widget.data[widget.index].first_name + " " + widget.data[widget.index].last_name,
                        phoneNumber: widget.data[widget.index].phone_number)
                );
                isButtonDisabled = true;
                setState(() {

                  membersOfTeamList.add(MemberOfTeam(
                      memberName: widget.data[widget.index].first_name + " " + widget.data[widget.index].last_name,
                      phoneNumber: widget.data[widget.index].phone_number));
                  getId(widget.index);
                  // CreateTeamInputs().createTeam("",membersOfTeamList);
                  print("custom team list: $membersOfTeamList");
                });
                final snackbar = SnackBar(content: Text("Added Team Member"));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              } else {
                final snackbar =  SnackBar(content: Text("This Member Has been Added Already"));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);

              }

            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: isButtonDisabled ? Icon(Icons.check_circle ,color: Colors.green,) : Icon(Icons.add_rounded, color: AppColors().defaultColor, size: 20.w,),
            ),
          ),
        ],
      ),
    );
  }
}

class MemberOfTeam {
  String memberName;
  String phoneNumber;

  MemberOfTeam({
    required this.memberName,
    required this.phoneNumber,
  });
}
