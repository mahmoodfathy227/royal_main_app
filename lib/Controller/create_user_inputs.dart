import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/user_outputs.dart';

class CreateUserInputs {

  String firstName;
  String lastName;
  String userType;
  String userRole;
  String phoneNumber;
  // String address;
  String email;
  String password;
  bool agreedOrNot;
  bool isClient;

  CreateUserInputs({
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.userRole,
    required this.phoneNumber,
    // required this.address,
    required this.email,
    required this.password,
    required this.agreedOrNot,
    required this.isClient,

  });

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference clients = FirebaseFirestore.instance.collection('Clients');

  Future<void> createUser(bool IsItClient , context , trueEmail) {
   print(" is it client ${isClient}");
   print("the email is ${trueEmail}");
    if(isClient){
      return clients
          .add({
        'name': firstName + lastName ,
        'email':  email,
        "latitude": Provider.of<UserOutputs>(context, listen: false).locationLatlng.latitude ,
        "longitude": Provider.of<UserOutputs>(context, listen: false).locationLatlng.longitude ,
        "locationName": Provider.of<UserOutputs>(context, listen: false).locationName,
        'phoneNumber' : phoneNumber,


      })        .then((value) => print("Client Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } else {

    }

    if(!isClient){
      print("creat non client");
      print(" email ${email}");
      print(" password ${password}");

      FirebaseAuth.instance.createUserWithEmailAndPassword(email: trueEmail, password: password).then((value) {
        print("User Creations Success !");
      });
    }
    // Call the User's CollectionReference to create a new user
    return users
        .add({
      'first_name': firstName,
      'last_name': lastName,
      'user_type': userType,
      'user_role': userRole,
      'phone_number': phoneNumber,
      // 'address': address,
      'email': email,
      'password': password,
      'agreed_or_not': agreedOrNot,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  


}