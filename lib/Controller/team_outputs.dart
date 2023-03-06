import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:royal_marketing/Model/team_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/team_model.dart';
import '../Model/test_task_model.dart';
import '../View/Widgets/custom_team_list__item.dart';

class TeamOutputs extends ChangeNotifier {

  List <TeamModel> teamsList = [];
  List <TeamModel> supervisorTeamList = [];
  List teamNumber = [];
  List<MemberOfTeam> membersOfTeamList = [];
  List numberOfTeams = [];
  List memberNames = [];
int teamCount = 0;
bool supervisorLoading  = false;
  int allTeamTasks = 0;
  int allDoneTeamTasks = 0;
String teamName = '';
bool isTeamLoading= false;
List<int> doneTasksTeamList = [];
  String supervisorName = '';
String supervisorEmail = '';
  List <TestTaskModel> NewcustomPipeLineTasks= [];
  List<int> doneGroup = [];
  List <TestTaskModel> groupDoneTasks = [];
  bool pipeLineLoading = false;
  List<String> pepeLineNames = [];
  List<String> pipeLinetasksCount = [];
  List<String> membersTeamNames = [];
  List<String> finalMembersList = [];
 List<int> tasksCountTeam = [];

  CollectionReference pipeLine =
  FirebaseFirestore.instance.collection('PipeLine');
  TeamOutputs();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference teams = FirebaseFirestore.instance.collection('Teams');

  Future<List> getTeams() async {
    isTeamLoading = true;
    teamsList.clear();

    await teams.get().then((doc) {
      for (var element in doc.docs) {
        teamsList.add(TeamModel.fromMap(element.data() as Map<String, dynamic>));

      }
      
    }).then((value) {


    });
    notifyListeners();


    print(teamsList[0].team_name);
    print("done !!");


    isTeamLoading = false;
    return teamsList;
  }
  addTeamMembers(MemberOfTeam memberOfTeam){
    membersOfTeamList.add(memberOfTeam);
    print("this is teammebers list count ${membersOfTeamList.length}");
  }
  addSupervisorName(String thisSupervisorName){
    supervisorName = thisSupervisorName;
    print("this is supervisor Name ${supervisorName}");
  }



addTeam(teamName , supervisorEmail) async{
    List <MemberOfTeam> newList = membersOfTeamList.toSet().toList();
  for(var element in membersOfTeamList){
    memberNames.add(element.memberName) ;
teamCount++;

  }
  await teams.doc().set({
    "team_name" : teamName,
    "supervisor_email" : supervisorEmail,
    "supervisor_name" : supervisorName,
    "team_count" : teamCount.toString(),
    "member_data" : memberNames.join(", "),

  }).then((value) {
    print("team added successfully");
    membersOfTeamList.clear();
    teamName = '';
    supervisorName = '';
    teamCount = 0;
    memberNames = [];

  });
}

clearAllTheFields(){
  membersOfTeamList.clear();
  teamName = '';
  supervisorName = '';
  teamCount = 0;
  memberNames = [];
  notifyListeners();
}
assignSupervisorEmail(customSupervisorEmail) async{
    supervisorEmail = customSupervisorEmail;
    final prefs = await SharedPreferences.getInstance();
   await prefs.setString("supervisorTag" , customSupervisorEmail );
    notifyListeners();
  }
getTeamData() async{
  supervisorLoading = true;
finalMembersList.clear();
membersTeamNames.clear();
  supervisorTeamList.clear();
  doneTasksTeamList.clear();
  tasksCountTeam.clear();
  allTeamTasks = 0;
  allDoneTeamTasks= 0;

  final prefs = await SharedPreferences.getInstance();
  String? savedSupervisorEmail = await prefs.getString("supervisorTag");
  print("this is the email ${savedSupervisorEmail}");


  await teams.where('supervisor_email' , isEqualTo: savedSupervisorEmail).get().then((doc) {
    for (var element in doc.docs) {
      supervisorTeamList.add(TeamModel.fromMap(element.data() as Map<String, dynamic>));

    }
print("this is the list ${supervisorTeamList}");
  }).then((value) {


  });



  print(supervisorTeamList[0].team_name);
  for(var element in supervisorTeamList){
    membersTeamNames.addAll(element.member_data.split(',').toList()) ;

  }
  for(var element in membersTeamNames){
    String member = element.replaceAll(" ", "");
    finalMembersList.add(member);
  }
print("list of team members ${finalMembersList}");




  
  for(var pipeLine in finalMembersList){
    await FirebaseFirestore.instance.collection("PipeLine").doc(pipeLine).collection("Tasks").get().then((value) {
      tasksCountTeam.add(value.docs.length) ;
    });

    await FirebaseFirestore.instance.collection("PipeLine").doc(pipeLine).collection("Tasks").get().then((value) {
      int doneTasksTeam = 0;
     for(var doc in value.docs){
       if(doc['isDone'] == true){
         doneTasksTeam++;
       }
     }
      doneTasksTeamList.add(doneTasksTeam);
    });
  }
  supervisorLoading = false;
  print("done List ${doneTasksTeamList}");
  print("all List ${tasksCountTeam}");
  print("supervisorLoading ${supervisorLoading}");
  allTeamTasks = tasksCountTeam.reduce((value, element) => value+element);
  allDoneTeamTasks =  doneTasksTeamList.reduce((value, element) => value+element);
  notifyListeners();
  return supervisorTeamList;
}
  getCustomTeamData(teamName) async{
    print(teamName);
    supervisorLoading = true;
    finalMembersList.clear();
    membersTeamNames.clear();
    supervisorTeamList.clear();
    doneTasksTeamList.clear();
    tasksCountTeam.clear();
    allTeamTasks = 0;
    allDoneTeamTasks= 0;
    final prefs = await SharedPreferences.getInstance();



    await teams.where('team_name' , isEqualTo: teamName).get().then((doc) {
      for (var element in doc.docs) {
        supervisorTeamList.add(TeamModel.fromMap(element.data() as Map<String, dynamic>));

      }
      print("this is the list ${supervisorTeamList}");
    }).then((value) {


    });



    print(supervisorTeamList[0].team_name);
    for(var element in supervisorTeamList){
      membersTeamNames.addAll(element.member_data.split(',').toList()) ;

    }
    for(var element in membersTeamNames){
      String member = element.replaceAll(" ", "");
      finalMembersList.add(member);
    }
    print("list of team members ${finalMembersList}");





    for(var pipeLine in finalMembersList){
      await FirebaseFirestore.instance.collection("PipeLine").doc(pipeLine).collection("Tasks").get().then((value) {
        tasksCountTeam.add(value.docs.length) ;
      });

      await FirebaseFirestore.instance.collection("PipeLine").doc(pipeLine).collection("Tasks").get().then((value) {
        int doneTasksTeam = 0;
        for(var doc in value.docs){
          if(doc['isDone'] == true){
            doneTasksTeam++;
          }
        }
        doneTasksTeamList.add(doneTasksTeam);
      });
    }
    supervisorLoading = false;
    print("done List ${doneTasksTeamList}");
    print("all List ${tasksCountTeam}");
    print("supervisorLoading ${supervisorLoading}");
    allTeamTasks = tasksCountTeam.reduce((value, element) => value+element);
    allDoneTeamTasks =  doneTasksTeamList.reduce((value, element) => value+element);
    notifyListeners();
    return supervisorTeamList;
  }
  Future <List<String>> getPipeLineNames() async{
    NewcustomPipeLineTasks.clear();
    doneGroup.clear();
    groupDoneTasks.clear();


    pipeLineLoading = true;

    pepeLineNames.clear();
    pipeLinetasksCount.clear();
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('PipeLine').get();

    final List<DocumentSnapshot> documents = result.docs;

    print("this is docs number ${documents.length}");
    documents.forEach((data){

      print("This is pipeLine names ${data.id}");
      pepeLineNames.add(data.id.toString());
    });





    pipeLineLoading = false;
    print("======== Task Names ${pepeLineNames}");
    print("======== Task count ${pipeLinetasksCount}");
    await getTasksCount();
    doneGroup.clear();

    for(var element in pepeLineNames){
      await getDonePipeLineTasks(element);

    }
    print("this is donegroup ${doneGroup}");
    print("checking length of names ${pepeLineNames.length}");
    notifyListeners();
    return pipeLinetasksCount;

  }

  getTasksCount() async{
    pipeLinetasksCount.clear();
    for(var element in pepeLineNames){
      QuerySnapshot result = await   FirebaseFirestore.instance.collection("PipeLine").doc(element).collection("Tasks").get();
      pipeLinetasksCount.add(result.size.toString());

    }

    print("the count is ${pipeLinetasksCount}");
    notifyListeners();
  }

  Future  getDonePipeLineTasks(String pipeLineName) async{


    print(""
        "checking all are cleared "
        "${doneGroup} ${groupDoneTasks} ${NewcustomPipeLineTasks}");

    await pipeLine.doc(pipeLineName).collection('Tasks').get().then((doc) {
      for (var element in doc.docs) {
        NewcustomPipeLineTasks.add(TestTaskModel.fromMap(element.data() as Map<String, dynamic>));
      }
    });


    print("tasks gotten count is  ${NewcustomPipeLineTasks.length}");
    for(var element in NewcustomPipeLineTasks ){
      if(element.isDone == true){
        groupDoneTasks.add(element);
        print("====Added");
      } else{
        print("====Not true thus not added");
      }



    }
    print("this is custom length for DoneTasks ${groupDoneTasks.length}");
    doneGroup.add(groupDoneTasks.length);

    print("length ========== ${doneGroup}");
    NewcustomPipeLineTasks.clear();
    groupDoneTasks.clear();
    notifyListeners();
  }

}

