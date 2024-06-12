
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/authentication/login/login_screen.dart';
import 'package:omani_agriculture_app/screens/welcome/welcome_screen.dart';



class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   stops: [0.0, 1.0],
          //   colors: [
          //     milkyColor,
          //     milkyColor,
          //   ],
          // ),
          image: DecorationImage(
            image: AssetImage("assets/images/main-page.png"), fit: BoxFit.cover,
          )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height*0.12,
            ),
            SizedBox(
              child: Image.asset('assets/images/logo.png',
                height: 120,
                color: darkBrownColor,
              ),
            ),
            SizedBox(
              height: size.height*0.35,
            ),
            Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                border: Border.all(color: Colors.white,width: 0.2),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(userType: 'Admin',)));

                  }, child: Text('Admin', style: buttonStyle)),
            ),
          SizedBox(
            height: size.height*0.03,
          ),
            Container(

              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                // ],
                border: Border.all(color: Colors.white,width: 0.2),
               // color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    darkBrownColor,
                    lightBrownColor,
                  ],
                ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen(userType: 'Users',)));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                    // );

                  }, child: Text('Customer', style: buttonStyle.copyWith(color: Colors.white))),
            ),
          SizedBox(
            height: size.height*0.03,
          ),

            Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                border: Border.all(color: Colors.white,width: 0.2),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(userType: 'Owner',)));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  }, child: Text('Owner', style: buttonStyle)),
            ),



        ],),
      ),
    );
  }
}
