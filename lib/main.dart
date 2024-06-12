import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omani_agriculture_app/model/getx_model.dart';
import 'package:omani_agriculture_app/screens/bottomNavBar/app_bottom_nav_bar_admin.dart';
import 'package:omani_agriculture_app/screens/bottomNavBar/app_bottom_nav_bar_instructor.dart';
import 'package:omani_agriculture_app/screens/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:omani_agriculture_app/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.length == 0) {


    if (Platform.isIOS) {
      await Firebase.initializeApp(
          options: FirebaseOptions(apiKey: 'AIzaSyBH7qA_xSrJ5eYmbHSCDEfuXSHqHdCsvzI',
              appId: '1:97089701565:android:02972d723ec132a52119d4',
              messagingSenderId: '97089701565',
              storageBucket:  "agriculture-store-flutter.appspot.com",
              projectId: 'coffee-app-2ec7f')
      );
    }
    else {
      await Firebase.initializeApp(
          options: FirebaseOptions(apiKey: 'AIzaSyBH7qA_xSrJ5eYmbHSCDEfuXSHqHdCsvzI',
            appId: '1:616859266128:android:45a420ca044a710ed5f555',
            messagingSenderId: '616859266128',
            projectId: 'coffee-app-2ec7f',
            storageBucket:  "agriculture-store-flutter.appspot.com",
          ));
    }

  }


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final cartController = Get.put(AddToCartController());
  String userType = '',email = '', uid = '';



  getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Starting usertype ' + prefs.getString('userType').toString());
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
       uid = prefs.getString('userId')!;
      });
      print(userType.toString() + ' This is user type');
    } else {
      print('Starting usertype');
    }

    if(userType != 'Admin') {
      cartController.fetchCartItems();
    }

  }
  @override
  void initState() {
    print('Starting usertype');

    // TODO: implement initState
    // setState(() {
    //   userType = '';
    //   email = '';
    //   uid = '';
    // });

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReCoffee Cycle',
      theme: ThemeData(fontFamily: 'Poppins'),
      home:
      userType == 'Users' ? AppBottomNavBarCustomerScreen(index: 0, title: userType, subTitle: uid,) :
      userType == 'Admin' ? AppBottomNavBarOwnerScreen(index: 0, title: userType, subTitle: uid,) :
      userType == 'Owner' ? AppBottomNavBarInstructorScreen(index: 0, title: userType, subTitle: uid,) :
      SplashScreen(userType: userType,),
    );
  }
}
