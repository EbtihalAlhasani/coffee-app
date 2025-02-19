
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/screens/admin/adminMonitoring/admin_monitoring_screen.dart';
import 'package:omani_agriculture_app/screens/authentication/userType/usertype_screen.dart';
import 'package:omani_agriculture_app/screens/order/order_history_screen.dart';
import 'package:omani_agriculture_app/screens/owner/recyclingInfo/recycling_info_screen.dart';
import 'package:omani_agriculture_app/screens/payment/payment_method_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ProfileScreen extends StatefulWidget {
  final String userType;
  const ProfileScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userType = '',email = '', uid = '',name = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId') ?? "";
      });
    }
      else {
      FirebaseFirestore.instance.collection(userType).where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
      getData();


    super.initState();
  }

 // final FirebaseAuth _auth = FirebaseAuth.instance;
  String subject = '';
  MethodsHandler _methodsHandler = MethodsHandler();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: milkyColor,

      body: Column(
        children: [

          Container(
              width: size.width,
              height: size.height*0.35,
              decoration: new BoxDecoration(
                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), bottomLeft: Radius.circular(50)),
                gradient: LinearGradient(begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.9
                  ], colors: [

                    darkBrownColor,
                    lightBrownColor,
                  ],
                ),
              ),
              child: Column(children: [
                Padding(
                  padding:  EdgeInsets.only(top: size.height*0.03),
                  child: Container(
                    height: size.height*0.08,
                    width: size.width,
                    child: Stack(
                      alignment: Alignment.centerRight,

                      children: [
                        Container(
                            width: size.width,
                            height: size.height*0.08,
                            child: Center(
                              child: Text('Profile',
                                style: TextStyle( fontFamily: "Poppins",color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],),

                  ),
                ),

                SizedBox(
                  height: size.height*0.01,
                ),

                Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage( 'assets/images/coffee_header.jpeg'),
                        ),
                      ],
                    )),

                SizedBox(
                  height: size.height*0.02,
                ),

                Container(
                    width: size.width,
                    child: Center(
                      child: Text(name == '' ? (widget.userType) : name,
                        style: TextStyle( fontFamily: "Poppins",color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    )),


                SizedBox(
                  height: size.height*0.01,
                ),

                Container(
                    width: size.width,
                    child: Center(
                      child: Text(email.isEmpty ? 'admin@gmail.com' : email,
                        style: TextStyle( fontFamily: "Poppins",color: Colors.white, fontSize: 13,fontWeight: FontWeight.w400),
                      ),
                    )),





              ],)
          ),


          SizedBox(
            height: 20,
          ),
          widget.userType != 'Users' ? Container() :
          Padding(
            padding: const EdgeInsets.only(top: 6,bottom: 4,left: 10,right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                side: BorderSide(width: 1,color: whiteColor),
                borderRadius: BorderRadius.circular(10),
              ),

              tileColor: whiteColor,
              leading: Container(
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 30,//devSize.height*0.05,
                child: Image.asset('assets/images/file.png',height: 30,width: 30,fit: BoxFit.scaleDown,),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, color: Colors.black,size: 15,
              ),
              title:  Text('Order History', style: body4Black),
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => OrderScreen(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 100),
                  ),
                );
                //_methodsHandler.signOut(context);

              },
            ),
          ),

          widget.userType != 'Owner' ? Container() :
          Padding(
            padding: const EdgeInsets.only(top: 6,bottom: 4,left: 10,right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                side: BorderSide(width: 1,color: whiteColor),
                borderRadius: BorderRadius.circular(10),
              ),

              tileColor: whiteColor,
              leading: Container(
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 30,//devSize.height*0.05,
                child: Image.asset('assets/images/recycle.png',height: 30,width: 30,fit: BoxFit.scaleDown,),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, color: Colors.black,size: 15,
              ),
              title:  Text('Recycling Info', style: body4Black),
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => RecyclingInfoScreen2(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 100),
                  ),
                );
              },
            ),
          ),

          widget.userType == 'Owner' ? Container() :
          Padding(
            padding: const EdgeInsets.only(top: 6,bottom: 4,left: 10,right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                side: BorderSide(width: 1,color: whiteColor),
                borderRadius: BorderRadius.circular(10),
              ),

              tileColor: whiteColor,
              leading: Container(
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 30,//devSize.height*0.05,
                child: Icon(Icons.call),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, color: Colors.black,size: 15,
              ),
              title:  Text('Contact Us', style: body4Black),
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => OrderScreen(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 100),
                  ),
                );
                //_methodsHandler.signOut(context);

              },
            ),
          ),

          widget.userType != 'Owner' ? Container() :
          Padding(
            padding: const EdgeInsets.only(top: 6,bottom: 4,left: 10,right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                side: BorderSide(width: 1,color: whiteColor),
                borderRadius: BorderRadius.circular(10),
              ),

              tileColor: whiteColor,
              leading: Container(
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 30,//devSize.height*0.05,
                child: Image.asset('assets/images/kpi.png',height: 30,width: 30,fit: BoxFit.scaleDown,),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, color: Colors.black,size: 15,
              ),
              title:  Text('Monitor Quantity', style: body4Black),
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => AdminMonitoringScreen(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 100),
                  ),
                );
                //_methodsHandler.signOut(context);

              },
            ),
          ),



          SizedBox(
            height: 6,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4,bottom: 4,left: 10,right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                side: BorderSide(width: 1,color: whiteColor),
                borderRadius: BorderRadius.circular(10),
              ),

              tileColor: whiteColor,
              leading: Container(
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 30,
                  height: 30,//devSize.height*0.05,
                  child: Image.asset('assets/images/shutdown.png',height: 30,width: 30,fit: BoxFit.scaleDown,),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, color: Colors.black,size: 15,
              ),
              title:  Text('Logout', style: body4Black),
              onTap: () async {
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
                _methodsHandler.signOut(context);

              },
            ),
          ),
          SizedBox(
            height: 10,
          ),

        ],
      )
    );
  }
}
