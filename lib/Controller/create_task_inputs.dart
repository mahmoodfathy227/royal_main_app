import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/task_model.dart';

class CreateTaskInputs {

  String clientName;
  String assignToName;
  String fromDate;
  String toDate;
  String fromTime;
  String toTime;
  String description;
  double latitude;
  double longitude;
  String client_locationName;
  String client_phoneNumber;
  String employee_email;

  CreateTaskInputs(
      {required this.clientName,
      required this.assignToName,
      required this.fromDate,
      required this.toDate,
      required this.fromTime,
      required this.toTime,
      required this.description,
      required this.latitude,
        required this.longitude,
        required this.client_locationName,
      required this.client_phoneNumber,
        required this.employee_email,

      });
static List <String>collectionNames = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference tasks = FirebaseFirestore.instance.collection('Tasks');
  CollectionReference pipeLine = FirebaseFirestore.instance.collection('PipeLine');
  Future<void> createTask()  async{
    // Call the Task's CollectionReference to create a new task
    return await tasks
        .add({
      'client_name': clientName,
      'assign_to_name': assignToName,
      'from_date': fromDate,
      'to_date': toDate,
      'from_time': fromTime,
      'to_time': toTime,
      'employee_email': employee_email,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': client_locationName,
      'client_phoneNumber': client_phoneNumber,
      'isDone' : false,
      'reason_of_visit' : "",
      'rep_sales_descroption' : "",
    })
        .then((value) {
      print("Task Added");

    }
    )
        .catchError((error) => print("Failed to add task: $error"));
  }



  Future<void> createTaskInPipeLine(assignToName , context)  async{



    return await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).collection("Tasks").doc().set({
      'client_name' : clientName,
      'assign_to_name' : assignToName,
      'from_date' : fromDate,
      'to_date' : toDate,
      'from_time' : fromTime,
      'to_time' : toTime,
      'description' : description,
      'employee_email' : employee_email,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': client_locationName,
      'client_phoneNumber' : client_phoneNumber,
      'isDone' : false,
      'reason_of_visit' : "",
      'rep_sales_descroption' : "",
    })

        .then((value) async {
      print("Task in Pipe Line Added");
      createTask();
      // createTask(assignToName , context);
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString("lastKey", pipeLineName);
      // await Provider.of<TaskOutputs>(context , listen: false).getPipeLineNames();
      // await Provider.of<TaskOutputs>(context , listen: false).getPipeLine();
      // await Provider.of<TaskOutputs>(context, listen: false).getLast();
    }

    )
        .catchError((error) => print("fatal error Failed to add Piep Line: $error"));
  }


  Future<void> createPipeLine(assignToName , context)  async{

print("start making pipeline");
await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).set({});
    return await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).collection("Tasks").doc().set({
      'client_name' : clientName,
      'assign_to_name' : assignToName,
      'from_date' : fromDate,
      'to_date' : toDate,
      'from_time' : fromTime,
      'to_time' : toTime,
      'description' : description,
      'employee_email' : employee_email,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': client_locationName,
      'client_phoneNumber' : client_phoneNumber,
      'isDone' : false,
      'reason_of_visit' : "",
      'rep_sales_descroption' : "",

    })

        .then((value) async {
      print("Pipe Line Added");
      createTask();

      // final prefs = await SharedPreferences.getInstance();
     // await prefs.setString("lastKey", pipeLineName);
     // await Provider.of<TaskOutputs>(context , listen: false).getPipeLineNames();
     // await Provider.of<TaskOutputs>(context , listen: false).getPipeLine();
      // await Provider.of<TaskOutputs>(context, listen: false).getLast();
      print("finish making pipeline");

    }

    )
        .catchError((error) => print("Failed to add Piep Line: $error"));

  }
  
  Future<void> updateTaskInPipeLine(updatedClientName) async{
    print(" at function ${latitude}");

    var gottenDoc =  await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).collection("Tasks").
    where("client_name" , isEqualTo:updatedClientName).get();

    DocumentReference docReference = gottenDoc.docs[0].reference;

    await FirebaseFirestore.instance.collection("PipeLine").doc(assignToName).collection("Tasks").
    doc(docReference.id).update({
      'client_name' : clientName,
      'assign_to_name' : assignToName,
      'from_date' : fromDate,
      'to_date' : toDate,
      'from_time' : fromTime,
      'to_time' : toTime,
      'description' : description,
      'employee_email' : employee_email,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': client_locationName,
      'client_phoneNumber' : client_phoneNumber,
      'isDone' : false
    }).then((value) {
      print("shoud be updated");
      print(docReference.path);
    });
  }

}