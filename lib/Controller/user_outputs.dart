import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:royal_marketing/Model/client_model.dart';
import 'package:royal_marketing/Model/user_model.dart';
import 'package:royal_marketing/View/Admin_screens/main_page_admin.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/main_page_rep.dart';
import 'package:royal_marketing/View/Supervisor_screens/main_page_supervisor.dart';

import '../Model/supervisor_model.dart';
import '../View/Accountant_Screens/main_page_acc.dart';

class UserOutputs extends ChangeNotifier{

  List<UserModel> usersList = [];
  List<SupervisorModel> supervisorList = [];
  List<ClientModel> clientsList = [];
  bool isLocationChecked = false;
  String locationName = "";
  LatLng locationLatlng = LatLng(0 , 0);

  List<UserModel> usersOfTasksList = [];
String userRole = "";
  //List tasksInPipelineList = [];
  //List usersOfTaskList = [];
  //TasksAndUsers? tasksAndUsers;
  //List tasksAndUsersList = [];


  UserOutputs();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference clients = FirebaseFirestore.instance.collection('Clients');
  CollectionReference supervisors = FirebaseFirestore.instance.collection('Supervisors');


  markLocationUnchecked(){
    isLocationChecked = false;
    notifyListeners();
print("location now unchecked");
  }
  Future<List> getUsers() async {
    usersList.clear();
    await users.get().then((doc) {
      for (var element in doc.docs) {
        usersList.add(UserModel.fromMap(element.data() as Map<String, dynamic>));
      }
      usersList.removeWhere((element) => element.user_type=="Admin");
    });
    notifyListeners();
    print("users done ${usersList}");
    return usersList;
  }

  updateRepsales({
    email,
    first_name ,
    last_name ,
    phone_number ,

  }) async{
    String queryId = "";
   QuerySnapshot query = await   FirebaseFirestore.instance.collection("Users").where(
      "email",
      isEqualTo: email
    ).get().then((value) {
     queryId = value.docs.first.id;
     return value;
   });
   
   FirebaseFirestore.instance.collection("Users").doc(queryId).update({

     'first_name' : first_name,
     'last_name' : last_name,
     'phone_number' : phone_number,
   }).then((value) {

     print("updated  Client success");
   });
  }

  updateClient({
    email ,
    name ,
    locationLat ,
    locationLng ,
    phoneNumber

  }) async{
    String queryId = "";
    QuerySnapshot query = await   FirebaseFirestore.instance.collection("Clients").where(
        "email",
        isEqualTo: email
    ).get().then((value) {
      queryId = value.docs.first.id;
      return value;
    });

    FirebaseFirestore.instance.collection("Clients").doc(queryId).update({

      'email' : email,
      'name' : name,
      'latitude' : locationLat,
      'longitude' : locationLng,
      'phoneNumber' : phoneNumber,

    }).then((value) {

      print("updated  Client success");
    });
  }

  Future<List> getSupervisors() async {
    supervisorList.clear();
    await supervisors.get().then((doc) {
      for (var element in doc.docs) {
        supervisorList.add(SupervisorModel.fromMap(element.data() as Map<String, dynamic>));
      }
    });
    notifyListeners();
    print("Supervisor done ${supervisorList}");
    return supervisorList;
  }

  Future<List> getClients() async {
    clientsList.clear();
    await clients.get().then((doc) {
      for (var element in doc.docs) {

        clientsList.add(ClientModel.fromMap(element.data() as Map<String, dynamic>));

      }
    });
    notifyListeners();
    print("clients done ${clientsList}");
    return clientsList;
  }



  ///////////////////Location////////////////////////////
  assignClientLocation(LatLng latlng){
    print(latlng);
    locationLatlng = latlng;
    notifyListeners();
  }


  assignLocationState(){
    isLocationChecked =true;
    notifyListeners();
  }

  Future<String> transformToLocationName() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(locationLatlng.latitude, locationLatlng.longitude);
    print(placemarks[0].administrativeArea! + placemarks[0].street! + placemarks[0].locality!  );
    locationName = placemarks[0].administrativeArea! + placemarks[0].street! + placemarks[0].locality!;
    notifyListeners();
    return placemarks[0].administrativeArea! + placemarks[0].subAdministrativeArea! + placemarks[0].locality!;
  }
  /*Future<List> getAssignToUsers(String firstName, String lastName) async {
    usersOfTasksList.clear();
    await users.where('first_name', isEqualTo: firstName).where('last_name', isEqualTo: lastName).get().then((doc) {
      for (var element in doc.docs) {
        usersOfTasksList.add(UserModel.fromMap(element.data() as Map<String, dynamic>));
      }
    });
    notifyListeners();
    return usersOfTasksList;
  }*/
  navigateUser(context) {
    print("this is ${userRole}");
    switch(userRole){

      case "Admin": (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)), (route) => false);
      print("admin Page");  };
      break;

      case "Accountant": (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageAcc(selectedItemPosition: 0)), (route) => false);
      print("acc Page");  };
 break;

      case "Supervisor": (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageSupervisor(selectedItemPosition: 0)), (route) => false);
        print("Supervisor Page");  };
      break;

      case "Rep Sales": (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageRep(selectedItemPosition: 0)), (route) => false);
      print("rep Page");  };

      break;
    }



  }
}