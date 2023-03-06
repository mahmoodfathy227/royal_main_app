import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:royal_marketing/Model/task_model.dart';
import 'package:royal_marketing/View/Admin_screens/main_page_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/team_model.dart';
import '../Model/test_task_model.dart';
import 'create_task_inputs.dart';

class TaskOutputs extends ChangeNotifier {
  LatLng locationLatlng = LatLng(0, 0);
  List<TestTaskModel> tasksList = [];
  List filteredTasks = [];
  List<TestTaskModel> selectedTasks = [];
  List<TestTaskModel> pipeLineList = [];
  int pipeLineLength = 0;
  String lastKey = "";
  bool isTasksLoading = false;
  DateTime customDate = DateTime.now();
  bool isLocationChecked = false;
  String locationName = "";
  TaskOutputs();
  bool isFilteredTasksLoading = false;
bool isFilteredRepTasksLoading = false;
  List<TestTaskModel> filteredRepTasks = [];
  List <TeamModel> teamList= [];
  List<String> pepeLineNames = [];
  List<String> customDatepepeLineNames = [];
  List<String> pipeLinetasksCount = [];
  bool pipeLineLoading = false;
  List <TestTaskModel> customPipeLineTasks= [];
  List <TestTaskModel> NewcustomPipeLineTasks= [];
  List customDatePipeLineCount = [];
String userId = "";
  String userName = "";



  List<int> doneGroup = [];
  List<DocumentSnapshot> documents = [];

List <TestTaskModel> groupDoneTasks = [];


  CollectionReference teams = FirebaseFirestore.instance.collection('Teams');

  FirebaseFirestore firestore = FirebaseFirestore.instance;
bool teamsLoading = false;
  CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');
  CollectionReference pipeLine =
      FirebaseFirestore.instance.collection('PipeLine');
  bool isCustomPipeLineTasksLoading = false;




Future <List<TestTaskModel>> getCustomPipeLineTasks(String pipeLineName) async{



   isCustomPipeLineTasksLoading = true;
  customPipeLineTasks.clear();


  await pipeLine.doc(pipeLineName).collection('Tasks').get().then((doc) {
    for (var element in doc.docs) {
      customPipeLineTasks
          .add(TestTaskModel.fromMap(element.data() as Map<String, dynamic>));
    }
  });

  print("tasks gotten ${customPipeLineTasks.length}");

int counter = 0;
  for(var element in customPipeLineTasks ){
    print("element is ${element.isDone}");
    element.isDone == true ? counter++ : print("no element is done yet");
  }
  doneGroup.add(counter);
   isCustomPipeLineTasksLoading = false;
   notifyListeners();
  return customPipeLineTasks;
}




  Future  getDonePipeLineTasks(String pipeLineName) async{
  await pipeLine.doc(pipeLineName).collection('Tasks').get().then((doc) {
      for (var element in doc.docs) {
        NewcustomPipeLineTasks.add(TestTaskModel.fromMap(element.data() as Map<String, dynamic>));
      }
    });



    for(var element in NewcustomPipeLineTasks ){
      if(element.isDone == true){
        groupDoneTasks.add(element);
        print("====Added");
      } else{
        print("====Not true thus not added");
      }



    }

    doneGroup.add(groupDoneTasks.length);

    NewcustomPipeLineTasks.clear();
groupDoneTasks.clear();
    notifyListeners();
  }




  Future <List<String>> getPipeLineNames() async{
  print("Staring........");
  isTasksLoading = true;
    NewcustomPipeLineTasks.clear();
    doneGroup.clear();
    groupDoneTasks.clear();

    documents.clear();
    pipeLineLoading = true;

    pepeLineNames.clear();
    pipeLinetasksCount.clear();
   await FirebaseFirestore.instance.collection('PipeLine').get().then((value) {
     documents = value.docs;
   });



print("this is docs number ${documents.length}");
    for (var data in documents) {

      print("This is pipeLine names ${data.id}");
    pepeLineNames.add(data.id.toString());
    }





    pipeLineLoading = false;
    print("======== Task Names ${pepeLineNames}");

    await getTasksCount();


     for(var element in pepeLineNames){
      await getDonePipeLineTasks(element);

    }
    print("======== Task count ${pipeLinetasksCount}");
     print("Done List = ${doneGroup}");
    notifyListeners();
  isTasksLoading = false;
    return pipeLinetasksCount;

  }



  updateTask(String clientName , reasonOfVisit , repSalesDescription) async{
    String docID = "";
  await FirebaseFirestore.instance.collection("Tasks").where("client_name" ,
  isEqualTo: clientName
  ).get().then((value) {
    docID = value.docs.first.id;
    print(value.docs.first.id);
  });
  FirebaseFirestore.instance.collection("Tasks").doc(docID).update({
    "isDone" : true,
    'reason_of_visit' : reasonOfVisit,
    'rep_sales_descroption' : repSalesDescription,
  });
    String docID2 = "";
    await FirebaseFirestore.instance.collection("PipeLine").doc(userName).collection("Tasks").
    where("client_name" ,
        isEqualTo: clientName
    ).get().then((value) {
      docID2 = value.docs.first.id;
      print(value.docs.first.id);
    });

    FirebaseFirestore.instance.collection("PipeLine").doc(userName).collection("Tasks").doc(docID2).
    update({
      "isDone" : true,
      'reason_of_visit' : reasonOfVisit,
      'rep_sales_descroption' : repSalesDescription,
    });

  }




  Future <List<TeamModel>> getTeams() async{
  print("team staring........");
  try{
    teamList.clear();
    await teams.get().then((doc) {
      for (var element in doc.docs) {
        teamList.add(TeamModel.fromMap(element.data() as Map<String, dynamic>));
      }
    });
    notifyListeners();
    print("teams done ${teamList}");
    return teamList;
  } catch(e){
  print("final errors in teams ${e.toString()}");
  return [];
  }


  }

  getTasksCount() async{
    pipeLinetasksCount.clear();
for(var element in pepeLineNames){
  QuerySnapshot result = await   FirebaseFirestore.instance.collection("PipeLine").doc(element).collection("Tasks").get();
  pipeLinetasksCount.add(result.size.toString());

}


    notifyListeners();
  }







  registerClientData(locationName, lat, lng) {
    locationName = locationName;
    locationLatlng = LatLng(lat, lng);
  }

  Future<List<TestTaskModel>> getTasks() async {
    tasksList.clear();

    await tasks.get().then((doc) {
      for (var element in doc.docs) {
        tasksList
            .add(TestTaskModel.fromMap(element.data() as Map<String, dynamic>));
      }
    });
    notifyListeners();
    print("tasks gotten ${tasksList}");
    return tasksList;
  }

  clearTheList(){
    filteredTasks.clear();
    filteredRepTasks.clear();
    notifyListeners();
  }

  clearAllTheLists(){
   pepeLineNames.clear();
   pipeLinetasksCount.clear();
   doneGroup.clear();
   groupDoneTasks.clear();
    notifyListeners();
  }
  assignLocationState() {
    isLocationChecked = true;
    notifyListeners();
  }

  assignClientLocation(LatLng latlng) {
    locationLatlng = latlng;
    notifyListeners();
  }

  Future<String> transformToLocationName() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locationLatlng.latitude, locationLatlng.longitude);
    print(placemarks[0].administrativeArea! +
        placemarks[0].street! +
        placemarks[0].locality!);
    locationName = placemarks[0].administrativeArea! +
        placemarks[0].street! +
        placemarks[0].locality!;
    notifyListeners();
    return placemarks[0].administrativeArea! +
        placemarks[0].subAdministrativeArea! +
        placemarks[0].locality!;
  }

  Future<List<TestTaskModel>> getPipeLine() async {
    pipeLineList.clear();
    print("Starting ...");
    final prefs = await SharedPreferences.getInstance();
    String? lastKey = prefs.getString("lastKey");
    if (lastKey == null || lastKey == "") {
      lastKey = "Qena";
    }

    print("this is last key !! ${lastKey}");

    await pipeLine.doc("collections").collection(lastKey).get().then((doc) {
      for (var elemt in doc.docs) {
        print("this is Gotten Data ${elemt.data()['clientName']}");
        pipeLineList
            .add(TestTaskModel.fromMap(elemt.data() as Map<String, dynamic>));
      }
    }).then((value) {});

    notifyListeners();

    print(" This is your List ${pipeLineList}");
    return pipeLineList;
  }

  Future getSelectedTasks() async {
    selectedTasks.clear();
    String? currentEmail = await FirebaseAuth.instance.currentUser?.email;

    await FirebaseFirestore.instance.collection("Users").where("email",
    isEqualTo: currentEmail ).get().then((value) {
      userId = value.docs.first.id;

    });
     DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(userId).get();
    String firstName = doc.get("first_name");
    String lastName = doc.get("last_name");
    userName = firstName+lastName;
    print("finally the name ia ${userName}");
    await getTasks().then((value) {
      tasksList.toSet().toList();
      for (var element in tasksList) {
        if (element.employee_email == currentEmail) {
          selectedTasks.add(element);

        } else {}
      }
    });

    print(tasksList.length);
  }

  filterRepTasksByDay(String date) async{

    isFilteredRepTasksLoading = true;
    // await getSelectedTasks();
    for (var i in selectedTasks) {
      if (i.fromDate == date) {
        filteredRepTasks.add(i);
      } else {

      }
    }
    print(date);
    print(filteredRepTasks.length);
    if (filteredRepTasks.isNotEmpty) {
      print(filteredRepTasks[0].description);
    }
    isFilteredRepTasksLoading = false;
    notifyListeners();
  }



  filterTasksByDay(String date) async {
    customDatepepeLineNames.clear();
    filteredRepTasks.clear();
    filteredTasks.clear();
    isFilteredTasksLoading = true;
    customDatePipeLineCount.clear();
    await getTasks();
    for (var i in tasksList) {
      if (i.fromDate == date) {
        filteredTasks.add(i);
      } else {

      }
    }
    print(date);
    print(filteredTasks.length);
    if (filteredTasks.isNotEmpty) {
      print(filteredTasks[0].description);
    }
    for(var element in filteredTasks){
    customDatepepeLineNames.add(element.assignToName.toString());

    }

    List<String>test = customDatepepeLineNames.toSet().toList();
    customDatepepeLineNames = test;
    print("final result ${customDatepepeLineNames}");
    for(var element in customDatepepeLineNames){
      QuerySnapshot result = await   FirebaseFirestore.instance.collection("PipeLine").doc(element).collection("Tasks").get();
      customDatePipeLineCount.add(result.size.toString());

    }

    print("the count is ${customDatePipeLineCount}");
    notifyListeners();
    isFilteredTasksLoading = false;
    notifyListeners();
  }


  minusToWeek(){
    customDate =   customDate.subtract(Duration(days: 7));
    print(customDate);
    notifyListeners();
  }


  addToWeek(){
    customDate =  customDate.add(Duration(days: 7));
    print(customDate);
    notifyListeners();
  }

  Future<String?> getLast() async {
    final prefs = await SharedPreferences.getInstance();
    lastKey = (await prefs.getString("lastKey"))!;
    if (lastKey == null || lastKey == "") {
      lastKey = "Qena";
    }
    return await prefs.getString("lastKey");
  }

  createSuperVisor(String name , BuildContext context , String email , String password) async{
    await FirebaseFirestore.instance.collection("Supervisors").doc().set({
      "name" : name
    }).then((value) {
      print("added supervisor");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.purpleAccent,
              content: Text(
                'supervisor added successfully',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp),
                textAlign: TextAlign.center,
              )));
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));
    });

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
}
