import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:royal_marketing/Controller/task_outputs.dart';
import 'package:royal_marketing/Controller/team_outputs.dart';
import 'package:royal_marketing/View/Accountant_Screens/home_screen_acc.dart';
import 'package:royal_marketing/View/Admin_screens/home_screen_admin.dart';
import 'package:royal_marketing/View/Rep.sales_Screens/home_screen_rep.dart';
import 'package:royal_marketing/View/Supervisor_screens/main_page_supervisor.dart';
import 'package:royal_marketing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/user_outputs.dart';
import 'View/Accountant_Screens/chat_screen.dart';
import 'View/Accountant_Screens/main_page_acc.dart';
import 'View/Admin_screens/calender_screen.dart';
import 'View/Admin_screens/create_task_screen.dart';
import 'View/Admin_screens/main_page_admin.dart';
import 'View/Rep.sales_Screens/apply_and_report_collect_screen.dart';
import 'View/Rep.sales_Screens/apply_and_report_order_screen.dart';
import 'View/Rep.sales_Screens/main_page_rep.dart';
import 'View/Rep.sales_Screens/profile_screen.dart';
import 'View/Screens/login_screen.dart';
import 'View/Screens/pre_signin_screen.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:royal_marketing/View/Screens/tab_screen.dart';

Widget? customWidget;
String? loginTag;
getCustomWidget<Widget>(){
  if(loginTag == 'admin'){
    return MainPageAdmin(selectedItemPosition: 0);
  } else if(loginTag == 'salesRep'){
    return MainPageRep(selectedItemPosition: 0);

  } else if(loginTag == 'accountant') {
    return MainPageAcc(selectedItemPosition: 0,);
  }
  else if(loginTag == 'supervisor') {
    return MainPageSupervisor(selectedItemPosition: 0,);
  }

  else {
    return customWidget = AnimatedSplashScreen(
      duration: 5000,
      splash: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/Background.png", fit: BoxFit.cover,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Splash_image.png", width: 130.w,fit: BoxFit.cover,),
                SizedBox(height: 20.h,),
                Text(
                  "Royal Marketing",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      nextScreen: const TabScreen(),
      backgroundColor: Colors.white,
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
 loginTag = await prefs.getString("loginTag");
 print("this user is ${loginTag}");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp()
  );
}


class MyApp extends StatelessWidget {

  // final AppRouter appRouter;

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      
      designSize: const Size(360, 740),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<UserOutputs>(create: (BuildContext context) => UserOutputs(),),
          ChangeNotifierProvider<TeamOutputs>(create: (BuildContext context) => TeamOutputs(),),
          ChangeNotifierProvider<TaskOutputs>(create: (BuildContext context) => TaskOutputs(),),
        ],
        child: MaterialApp(
          title: 'Royal Marketing',
          debugShowCheckedModeBanner: true,

          // onGenerateRoute: appRouter.generateRoute,
          builder: (context, widget)  {

            //add this line
            return Stack(children: [

              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              )
            ],);
          },//DevicePreview.appBuilder,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          //todo 3

          home:
          //ApplyAndReportOrderScreen()
          getCustomWidget()

        ),
      ),
    );
  }
}
