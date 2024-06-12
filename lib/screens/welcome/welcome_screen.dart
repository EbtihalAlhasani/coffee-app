
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/authentication/login/login_screen.dart';
import 'package:omani_agriculture_app/screens/authentication/signup/signup_screen.dart';
class WelcomeScreen extends StatefulWidget {
  final String userType;

  const WelcomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/main-page.png"), fit: BoxFit.cover
          ),),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height*0.12,
                ),
                Center(
                  child:  SizedBox(
                    child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,
                      height: 120,
                      color: darkBrownColor,
                    ),
                  ),
                ),

              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                      ],
                      // border: Border.all(width: 0.5,color: Colors.black),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          darkBrownColor,
                          lightBrownColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                        ),

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(userType: widget.userType,)));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => LoginScreen()),
                          // );
                        }, child: Text('Login', style: buttonStyle)),
                  ),
                  SizedBox(
                    height: size.height*0.025,
                  ),
                  Container(

                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                      // ],
                      border: Border.all(color: Colors.black,width: 0.5),
                      color: Colors.white,
                      // color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                        ),

                        onPressed: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                          // );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(userType: widget.userType,)));
                        }, child: Text('Sign up', style: buttonStyle.copyWith(color: Colors.black))),
                  ),
                  SizedBox(
                    height: size.height*0.13,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
