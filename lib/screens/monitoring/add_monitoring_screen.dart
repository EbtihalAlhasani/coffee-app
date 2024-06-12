import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/payment/payment_method_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Subscription { oneMonth, threeMonth, sixMonth, oneYear }
class AddMonitoringScreen extends StatefulWidget {
  const AddMonitoringScreen({Key? key}) : super(key: key);

  @override
  _AddMonitoringScreenState createState() => _AddMonitoringScreenState();
}

class _AddMonitoringScreenState extends State<AddMonitoringScreen> {
  final TextEditingController _addressControler = TextEditingController();
  Subscription _site = Subscription.oneMonth;
  bool _isLoading = false;

  String userType = '',email = '', uid = '',name = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      userType = '';
      email = '';
      uid = '';
    });
    //if(widget.userType == 'Users' || widget.userType == 'Farmer') {
    getData();
    // }


    super.initState();
  }


  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });
      FirebaseFirestore.instance.collection(userType).where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });


    } else {
      print('Starting usertype');
    }

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Monitoring',
          style: TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:0, title: '',)));
              // Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(
                'assets/images/arrow_back.png',
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(
            height: size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20,),
                    child: Text(
                        'Farm Location ',
                        style: body1Black
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  //border: Border.all(color: greyColor1, width: 0.5),
                  color: Colors.white,

                ),

                child: TextFormField(
                  controller: _addressControler,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  style: TextStyle( fontFamily: "Poppins",color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: whiteColor,
                    contentPadding: EdgeInsets.only(left: 9.0,top: 10,bottom: 0),
                    hintText: 'Farm Location',
                    labelStyle: body1Black,
                    hintStyle: TextStyle( fontFamily: "Poppins",color: greyColor),
                  ),
                  onChanged: (String value){
                  },
                )),
          ),




          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20,),
                    child: Text(
                        'Duration of subscription ',
                        style: body1Black
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),


          Container(
            width: size.width * .9,

            decoration:
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3,bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [

                    Radio(
                      activeColor: primaryColor,
                      value: Subscription.oneMonth,
                      groupValue: _site,
                      onChanged: (Subscription? value) {
                        setState(() {
                          _site = value!;
                        });
                        print(_site.toString());
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5,),
                      child: Text(
                        'One month / 30 OMR',
                        style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ],),


                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),


          Container(
            width: size.width * .9,

            decoration:
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3,bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [

                    Radio(
                      activeColor: primaryColor,
                      value: Subscription.threeMonth,
                      groupValue: _site,
                      onChanged: (Subscription? value) {
                        setState(() {
                          _site = value!;
                        });
                        print(_site.toString());
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5,),
                      child: Text(
                        'Three months / 90 OMR',
                        style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ],),


                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),


          Container(
            width: size.width * .9,

            decoration:
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3,bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [

                    Radio(
                      activeColor: primaryColor,
                      value: Subscription.sixMonth,
                      groupValue: _site,
                      onChanged: (Subscription? value) {
                        setState(() {
                          _site = value!;
                        });
                        print(_site.toString());
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5,),
                      child: Text(
                        'Six months / 180 OMR',
                        style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ],),


                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),

          Container(
            width: size.width * .9,

            decoration:
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3,bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [

                    Radio(
                      activeColor: primaryColor,
                      value: Subscription.oneYear,
                      groupValue: _site,
                      onChanged: (Subscription? value) {
                        setState(() {
                          _site = value!;
                        });
                        print(_site.toString());
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5,),
                      child: Text(
                        'One year / 360 OMR',
                        style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ],),


                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),


          SizedBox(
            height: size.height*0.05,
          ),
          _isLoading ? CircularProgressIndicator(
            color: primaryColor,
            strokeWidth: 2
            ,
          ) :
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
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
                    minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),

                  onPressed: () async {

                    print(name.toString() + uid.toString() + " uid");
                    if (_addressControler.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Farm Location",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {

                      setState(() {
                        _isLoading = true;
                      });

                      FirebaseFirestore.instance
                          .collection('monitoring')
                          .doc()
                          .set({
                        "location": _addressControler.text,
                        "subscription": _site.name.toString(),
                        "name": name.toString(),
                        "userId": uid.toString(),
                        "status": "Pending",
                      }).then((value) {
                        setState(() {
                          _isLoading = false;
                        });


                        Navigator.of(context).pop();

                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => PaymentMethodScreen(
                              amount:
                              _site.name.toString() == 'oneMonth' ? '30 OMR' :
                              _site.name.toString() == 'threeMonth' ? '90 OMR' :
                              _site.name.toString() == 'sixMonth' ? '180 OMR' : '360 OMR'

                              ,

                            ),
                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                            const  SnackBar(
                                backgroundColor: Colors.green,
                                content:  Text('Successfully submit',style: TextStyle( fontFamily: "Poppins",color: whiteColor),)
                            )
                        );

                      });

                    }

                  }, child: Text('Submit', style: buttonStyle)),
            ),
          ),
          SizedBox(
            height: size.height*0.1,
          ),


        ],),
      ),
    );
  }
}
