import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/View/Supervisor_screens/main_page_supervisor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/Accountant_Screens/main_page_acc.dart';
import '../../View/Admin_screens/main_page_admin.dart';
import '../../View/Rep.sales_Screens/main_page_rep.dart';
import '../../contants.dart';
import '../user_outputs.dart';

class EmailUser {
  String? _token;
  String? cred;
  EmailUser();

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('https://identitytoolkit.com/v1/accounts:$urlSegment?key=\'AIzaSyBCptMXTx1biTB3-0WxTmlJQHf1u-3DOGA\'');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    print(responseData);
    _token = responseData['idToken'];
    print('************************$_token');
    try {
      if (urlSegment == "signUp") {
        sharedPreferences.setString("token", _token.toString());
      }
    } catch (e) {
      print(e);
    }
    print("true");
  }

  Future<String> register(String email, String password) async{

    try {
      final auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      _authenticate(email, password, 'signUp');
      return auth.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return 'Code message: ${e.code}';
    }catch (e) {
      print(e);
      return 'Error: $e';
    }
  }


   signIn(String email, String password , context) async{
    final auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) async {
      cred = value.user?.uid;
      if(cred != null && cred != ""){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: AppColors().defaultColor,
                content: Text(
                  'Success',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp),
                  textAlign: TextAlign.center,
                )));
        if(Provider.of<UserOutputs>(context , listen: false).userRole == "Admin") {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)), (route) => false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginTag', 'admin');
          await prefs.setString('currentEmail', email);

        } else if (Provider.of<UserOutputs>(context , listen: false).userRole == "Accountant"){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageAcc(selectedItemPosition: 0)), (route) => false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginTag', 'accountant');
          await prefs.setString('currentEmail', email);
        }
        else if (Provider.of<UserOutputs>(context , listen: false).userRole == "Supervisor"){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageSupervisor(selectedItemPosition: 0)), (route) => false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginTag', 'supervisor');
          await prefs.setString('currentEmail', email);
        }


        else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MainPageRep(selectedItemPosition: 0)), (route) => false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginTag', 'salesRep');
          await prefs.setString('currentEmail', email);
        }
      }
  });
        }


//   Future<String> signIn(String email, String password , context) async {
//
//     try{
//       final auth = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//           email: email,
//           password: password
//       ).then((value) {
// cred = value.user?.uid;
// print("this is cred ${cred}");
//           // ScaffoldMessenger.of(context).showSnackBar(
//           //     SnackBar(
//           //         backgroundColor: AppColors().defaultColor,
//           //         content: Text(
//           //           'Success',
//           //           style: TextStyle(
//           //               color: Colors.black,
//           //               fontSize: 16.sp),
//           //           textAlign: TextAlign.center,
//           //         )));
//
//
//       });
//       _authenticate(email, password, 'signInWithPassword');
//
//       return auth.user!.uid;
//
//
//     } on FirebaseAuthException catch (e) {
//
//
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//       return 'Code message: ${e.code}';
//     } catch (e) {
//       print(e);
//       return 'Error: $e';
//     }
//   }

  Future<void> signOut() async =>
      await FirebaseAuth.instance.signOut();

  Future<void> changePassword(String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(newPassword);
    _token = sharedPreferences.getString("token");
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:update?key=\'AIzaSyBCptMXTx1biTB3-0WxTmlJQHf1u-3DOGA\'');
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}