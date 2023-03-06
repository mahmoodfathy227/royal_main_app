import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/create_team_inputs.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/Model/supervisor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../contants.dart';

class CustomTeamSupervisorItem extends StatefulWidget{

  var data;

  CustomTeamSupervisorItem( this.data);

  @override
  State<CustomTeamSupervisorItem> createState() => _CustomTeamListItemState();
}

class _CustomTeamListItemState extends State<CustomTeamSupervisorItem> {
  bool isButtonDisabled = false;
  List<MemberOfTeam> membersOfTeamList = [];

String supervisorName = "";

  @override
  Widget build(BuildContext context) {
    print("this is the data ${widget.data}");
    List <SupervisorModel> NewModel = widget.data;
    List<String> supervisorList = [];
    for(var supervisor in NewModel){

      supervisorList.add(supervisor.name);
    }

    return Row(
        children: [
    Container(
    padding: EdgeInsets.all(8.r),
    child: Icon(
    Icons.person,
    color: AppColors().defaultColor,
    size: 35.w,
    ),
    ),
    Expanded(
    child: DropdownSearch<String>(
    popupProps:  const PopupProps.dialog(
    showSelectedItems: true,
    showSearchBox: true,


    ),
    items: supervisorList,

    dropdownDecoratorProps: const DropDownDecoratorProps(
    dropdownSearchDecoration: InputDecoration(
    labelText: "Select Supervisor",
    hintText: "Select Supervisor",
    ),
    ),
    selectedItem: supervisorName,
onSaved: (value){
  print("this is name ${supervisorName}");
  setState(() {
    supervisorName = value.toString() ;
    print("updated ui");
  },

  );


},
    onChanged: (value){


    print("this is name ${supervisorName}");
    setState(() {
      supervisorName = value.toString() ;
      print("updated ui");
    },

    );


    }))],
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
