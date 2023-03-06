import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/View/Widgets/custom_team_list__item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTeamInputs {

  String? memberName;
  String? phoneNumber;
  String? documentId;
  //var buttonId;
  //List membersOfTeamList = [];


  CreateTeamInputs(){
    //buttonId = CreateTeamScreen().getId;
  }

  /*void getList (List list){
    for(int i=0;i<list.length;i++){
      membersOfTeamList.add(list[i]);
      print("get list: $membersOfTeamList");
    }
  }*/



  Future<void> createTeam(String teamName, List<MemberOfTeam> membersOfTeamList) async {
    // Call the Team's CollectionReference to create a new team

    //CollectionReference teamList = FirebaseFirestore.instance.collection('Teams');
    //CollectionReference addTeamName = FirebaseFirestore.instance.collection('Teams/$docId');

    getTime<Date>(){
      return DateTime.now();
    }
    final fixedTime = getTime();


    for(int i=0;i<membersOfTeamList.length;i++){
      MemberOfTeam memberOfTeam = membersOfTeamList[i];
      memberName = memberOfTeam.memberName;
      phoneNumber = memberOfTeam.phoneNumber;
      print("get member of team: $memberName , $phoneNumber");

    }
List<MemberOfTeam> filteredTeamList = membersOfTeamList.toSet().toList();
    print(filteredTeamList);
    print("this is the length ${filteredTeamList}");
    print(teamName);

    if(teamName.isNotEmpty){
      //Add Team Name and Number
      DocumentReference addTeamName = FirebaseFirestore.instance.collection('Teams').doc(fixedTime.toString());
      await addTeamName.set({
        'team_name':teamName,
        'team_number':filteredTeamList.length.toString()
      }).then((value) async{
        print("Team Name Added");
        print("Team Number Added");

        }).then((value) async {
        if(membersOfTeamList.isNotEmpty){
          DocumentReference teamList = FirebaseFirestore.instance.collection('Teams').doc(fixedTime.toString()).collection('MemberData').doc(filteredTeamList.length.toString());
          for(var member in filteredTeamList){
            await teamList.collection(member.memberName).doc().set({
              'member_name': member.memberName,
              'phone_number': member.phoneNumber
            }).then((value) {
              // documentId = teamList.path.split("/")[1];
              // prefs.setString('documentId', documentId!);
              print("Team Added");
              // print(documentId);
              // print("$buttonId");

            }).catchError((error) => print("Failed to add team: $error"));
          }

        }

      });

        membersOfTeamList.clear();
        filteredTeamList.clear();
        memberName = '';

    }



  }

  /*Future<void> createTeamName(String teamName) {
    // Call the Team's CollectionReference to create a new team
    return teams.doc(currentUser!.uid).update({
      'team_name':teamName
    })
        .then((value) => print("Team Added"))
        .catchError((error) => print("Failed to add team: $error"));
  }*/
}