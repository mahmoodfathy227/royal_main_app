import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/View/Admin_screens/edit_client_screen.dart';
import 'package:royal_marketing/View/Admin_screens/specific_client_screen.dart';
import 'package:royal_marketing/View/Admin_screens/specific_edit_delete_client.dart';
import 'package:royal_marketing/View/Widgets/custom_contact_list_item.dart';
import 'package:royal_marketing/View/Widgets/custom_delete_dialog.dart';

import '../../Controller/user_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_text_form_field.dart';
import '../Widgets/image_profile_and_notification.dart';
import 'main_page_admin.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors().defaultColor,
        centerTitle: true,
        toolbarHeight: 60.h,
        title: GestureDetector(
          onTap: (){
            Provider.of<UserOutputs>(context , listen: false).getClients();
          },
          child: Text(
            "Contacts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SpecificAddClientScreen()));
          },
          icon: CircleAvatar(
            radius: 66,
            backgroundColor: Colors.white,
            child: Icon(Icons.add , color: AppColors().defaultColor, size: 25,),),
        ),
        actions: ImageProfileAndNotification().imageProfileAndNotificationWithPoint(context),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25))),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              hint: "Search",
              fontSize: 22.sp,
              icon: "assets/icons/Search_icon.svg",
              iconColor: Colors.black45,
            ),
            FutureBuilder(
              future: Provider.of<UserOutputs>(context , listen: false).getClients(),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                } else {
                  return Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: EdgeInsets.all(5.r),
                      child: ListView.builder(
                        itemCount: Provider.of<UserOutputs>(context , listen: true).clientsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SpecificEditDeleteClientScreen(
                                  comingEmail: Provider.of<UserOutputs>(context , listen: false).clientsList[index].email ,
                                  cominglat: Provider.of<UserOutputs>(context , listen: false).clientsList[index].latitude,
                                  cominglng: Provider.of<UserOutputs>(context , listen: false).clientsList[index].longitude,
                                  comingName: Provider.of<UserOutputs>(context , listen: false).clientsList[index].name,
                                  comingPhoneNumber: Provider.of<UserOutputs>(context , listen: false).clientsList[index].phoneNumber,
                                )));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 45.h,
                                    width: 45.w,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Image.asset("assets/images/Person_image.png", fit: BoxFit.cover,),
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(

                                        width: 120.w,

                                        child: Text(
                                          Provider.of<UserOutputs>(context , listen: false).clientsList[index].name,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        Provider.of<UserOutputs>(context , listen: false).clientsList[index].phoneNumber!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: (){

                                    },
                                    icon: SvgPicture.asset("assets/icons/Chat_icon.svg", color: Colors.grey, width: 33.w,),
                                  ),
                                  SizedBox(width: 3.w,),
                                  IconButton(
                                      onPressed: () async{
                                        await _callNumber(Provider.of<UserOutputs>(context , listen: false).clientsList[index].phoneNumber);
                                      },
                                      icon: SvgPicture.asset("assets/icons/Phone_icon.svg", color: Colors.grey, width: 20.w,)),
                                  IconButton(
                                      onPressed: () async{
                                        showDialog(context: context, builder: (context)=>
                                            DeleteDialog(DeleteFunction: () async {

                                              var gottenDoc =  await FirebaseFirestore.instance.collection("Clients").
                                              where("name" , isEqualTo:Provider.of<UserOutputs>(context , listen: false).clientsList[index].name).get();

                                              DocumentReference docReference = gottenDoc.docs[0].reference;
                                              await FirebaseFirestore.instance.collection("Clients").
                                              doc(docReference.id).delete().then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.deepPurpleAccent,
                                                  content: Text(
                                                    'This Client is Deleted',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));
                                              });
                                            })
                                        );
                                      },
                                      icon: SvgPicture.asset("assets/icons/Delete_icon.svg", color: Colors.grey, width: 20.w,)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },

            ),
          ],
        ),
      ),
    );

  }
  _callNumber(number) async{

    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
