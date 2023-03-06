import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/create_team_inputs.dart';
import 'package:royal_marketing/Controller/user_outputs.dart';

import '../../Controller/team_outputs.dart';
import '../../contants.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_supervisor_list_item.dart';
import '../Widgets/custom_team_list__item.dart';
import '../Widgets/custom_text_form_field.dart';
import 'main_page_admin.dart';

class CreateTeamScreen extends StatefulWidget {


  const CreateTeamScreen({Key? key}) : super(key: key);

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController teamNameController = TextEditingController();
  TextEditingController teamSupervisorEmailController = TextEditingController();


  String? teamName;
  var user;
  var supervisor;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserOutputs>(context, listen: false);
    supervisor = Provider.of<UserOutputs>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().defaultColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: (){
                          Provider.of<TeamOutputs>(context , listen: false).clearAllTheFields();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white,),
                      ),
                      SizedBox(width: 60.w,),
                      Text(
                        "Create Team",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h,),
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Container(
                      width: 80.w,
                      height: 6.h,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                SizedBox(height: 8.h,),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                                    child: teamNameTextFormField(),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 25.w),

                                    child: FutureBuilder(
                                      future: supervisor.getSupervisors(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Center(
                                            heightFactor: 50.h,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              color: AppColors().defaultColor,
                                            ),
                                          );
                                        } else if(snapshot.hasError){
                                          return const Center(
                                            child: Text("Error"),
                                          );
                                        } else {
                                          if(snapshot.hasData){
                                            print("the gotten data is ${snapshot.data}");
                                            var data;
                                            data = snapshot.data;
                                            return SingleChildScrollView(
                                              child: Container(

                                                padding: EdgeInsets.all(22.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(22),
                                                      border: Border.all(
                                                          color: AppColors().defaultColor,
                                                          width: 2
                                                      )
                                                  ),
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 120.h,
                                                  child: CustomTeamSupervisorItem(data)
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child: Text("No data"),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: 25.w),
                                  //   child: CustomTextFormField(
                                  //     hint: "Search",
                                  //     fontSize: 22.sp,
                                  //     icon: "assets/icons/Search_icon.svg",
                                  //     iconColor: Colors.black45,
                                  //   ),
                                  // ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Select Members :" ,
                                      style: TextStyle(fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            Container(

                              padding: EdgeInsets.symmetric(horizontal: 25.w),

                              child: FutureBuilder(
                                future: user.getUsers(),
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(
                                      heightFactor: 50.h,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: AppColors().defaultColor,
                                      ),
                                    );
                                  } else if(snapshot.hasError){
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  } else {
                                    if(snapshot.hasData){
                                      return Container(
                                        height:MediaQuery.of(context).size.height,
                                        child: SingleChildScrollView(
                                          child: Container(

                                            width: 320.w,
                                            height:MediaQuery.of(context).size.height,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return CustomTeamListItem(index, snapshot.data);
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("No data"),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),



                                  SizedBox(height: 15,),




                                ] ),
                              ),
                            ),
                          ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  CustomButton(

        text: 'Create',
        onPressed: (){
          _formKey.currentState!.save();
          if(_formKey.currentState!.validate()){
            Provider.of<TeamOutputs>(context , listen: false).addTeam(teamNameController.text , "");
            // CreateTeamInputs().createTeam(teamName!, Provider.of<TeamOutputs>(context , listen: false).membersOfTeamList);
            print(teamName);
            Provider.of<TeamOutputs>(context , listen: false).getTeams();

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
              backgroundColor: Colors.deepPurpleAccent,
              content: Text(
                'The team is Created',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ));
            Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPageAdmin(selectedItemPosition: 0)));

          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
              content: Text(
                'Please fill all the fields',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ));
          }
        },
      )
    );
  }

  Widget teamNameTextFormField(){
    return TextFormField(
      controller: teamNameController,
      onSaved: (value){
        teamName = value;
      },
      validator: (value){
        if(value!.isEmpty){
          return "Please enter team name";
        }
        return null;
      },
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: "Team Name",
        hintStyle: TextStyle(
          color: Colors.black45,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: EdgeInsets.all(18.r),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
  Widget superVisorEmailTextFormField(){
    return TextFormField(
      controller: teamSupervisorEmailController,
      onSaved: (value){
        teamName = value;
      },
      validator: (value){
        if(value!.isEmpty){
          return "Please enter Email";
        }
        return null;
      },
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: "Supervisor Email",
        hintStyle: TextStyle(
          color: Colors.black45,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: EdgeInsets.all(18.r),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

}
