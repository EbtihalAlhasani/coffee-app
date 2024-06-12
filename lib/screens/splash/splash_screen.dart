import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/authentication/userType/usertype_screen.dart';
import 'package:omani_agriculture_app/screens/welcome/welcome_screen.dart';
//import 'package:mec/constants.dart';



class SplashScreen extends StatefulWidget {
  final String userType;

  //final Color backgroundColor = Colors.white;
  //final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  const SplashScreen({Key? key, required this.userType, }) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 2; // delay for 5 seconds

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserType()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
     // backgroundColor: primaryColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: new BoxDecoration(

          gradient: LinearGradient(begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
            0.1,
            0.9
          ], colors: [
            milkyColor,
              milkyColor,
              // darkBrownColor
          ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 120,
                // width: 120,
                child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown,)),
          ],
        ),
      ),
    );
  }
}
