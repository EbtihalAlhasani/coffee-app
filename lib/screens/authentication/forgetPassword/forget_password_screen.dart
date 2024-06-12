import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/model/input_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String userType;
  const ForgetPasswordScreen({Key? key
  , required this.userType
  }) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailControoler = TextEditingController();
  bool _isLoading = false;
  bool _isVisible = false;
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '';
  String isCreatedStudent = '';

  @override
  void initState() {
    //print('Owner ${widget.userType}');
    // TODO: implement initState
    // if( widget.userType == 'Owner') {
    //
    //   setState(() {
    //     _emailControoler.text = 'admin@gmail.com';
    //     _passwordControoler.text = '12345678';
    //   });
    //
    // }
    // else {
    //   setState(() {
    //     _emailControoler.text = 'alirahman@gmail.com';
    //     _passwordControoler.text = '12345678';
    //   });
    // }
    setState(() {



      isCreated = '';
      isCreatedStudent = '';
      _isVisible = false;
      _isLoading = false;
    });
    print('userType');
   // print(widget.userType.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // return  final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: new BoxDecoration(
            color: Colors.white,

          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: size.height*0.4,
                      width: size.width,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            colors: [
                              darkBrownColor,
                              lightBrownColor,

                            ],
                          ),
                        ),
                        child: Image.asset('assets/images/coffee_header.jpeg', fit: BoxFit.cover,
                          height: size.height*0.4,
                          width: size.width,
                        ),
                      ),
                    ),
                  ),

                ],),

              SingleChildScrollView(
                child: Container(
                  height: size.height,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [


                      Container(height: size.height*0.7,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)
                            )
                        ),
                        child: Column(
                          children: [

                            SizedBox(
                              height: size.height*0.05,
                            ),

                            Center(
                              child: SizedBox(
                                height: 80,
                                child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown,
                                  height: 80,),
                              ),
                            ),

                            SizedBox(
                              height: size.height*0.03,
                            ),

                            Center(
                                child: Text('Forget Password', style: TextStyle( fontFamily: "Poppins",color: Color(0xFF585858), fontSize: 16,fontWeight: FontWeight.bold),)
                            ),

                            SizedBox(
                              height: size.height*0.05,
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                              child: TextFormField(
                                controller: _emailControoler,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle( fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.black,

                                ),
                                onChanged: (value) {
                                  // setState(() {
                                  //   userInput.text = value.toString();
                                  // });
                                },
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  focusColor: Colors.white,
                                  //add prefix icon

                                  // errorText: "Error",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: darkGreyTextColor1, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "",

                                  //make hint text
                                  hintStyle: TextStyle( fontFamily: "Poppins",
                                    color: Colors.grey,
                                    fontSize: 16,
                                    
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'Email Address',
                                  //lable style
                                  labelStyle: TextStyle( fontFamily: "Poppins",
                                    color: darkBrownColor,
                                    fontSize: 16,
                                    
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height*0.02,
                            ),


                            _isLoading
                                ? CircularProgressIndicator(
                              color: darkBrownColor,
                              strokeWidth: 2,
                            )
                                :
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


                                      if (_inputValidator
                                          .validateEmail(_emailControoler.text) !=
                                          'success' &&
                                          _emailControoler.text.isNotEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const  SnackBar(
                                                backgroundColor: darkBrownColor,
                                                content:  Text('Wrong email, please use a correct email')
                                            )
                                        );
                                      }

                                      else {
                                        if (_emailControoler.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const  SnackBar(
                                                  backgroundColor: darkBrownColor,
                                                  content:  Text('Enter Email Address')
                                              )
                                          );
                                        }

                                        else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                          try {
                                            if (widget.userType == 'Users') {
                                              final snapshot = await FirebaseFirestore.instance.collection('Users').get();
                                              snapshot.docs.forEach((element) {
                                                print('user data');
                                                if(element['email'] == _emailControoler.text.toString().trim()) {
                                                  print('user age in if of current user ');
                                                  //   print(element['age']);
                                                  setState(() {
                                                    isCreated = 'yes';
                                                  });
                                                }
                                              });

                                              if(isCreated == 'yes') {
                                                final result =
                                                await _auth.sendPasswordResetEmail(
                                                    email: _emailControoler.text
                                                        .trim()
                                                        .toString(),);

                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const  SnackBar(
                                                        backgroundColor: darkBrownColor,
                                                        content:  Text('Password reset email sent, check your mail')
                                                    )
                                                );
                                              }
                                              else {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                _methodsHandler.showAlertDialog(
                                                    context, 'Sorry', 'User Not Found');
                                              }
                                            }
                                            else if (widget.userType == 'Farmer') {
                                              final snapshot = await FirebaseFirestore.instance.collection('Farmer').get();
                                              snapshot.docs.forEach((element) {
                                                print('user data');
                                                if(element['email'] == _emailControoler.text.toString().trim()) {
                                                  print('user age in if of current user ');
                                                  //   print(element['age']);
                                                  setState(() {
                                                    isCreated = 'yes';
                                                  });
                                                }
                                              });

                                              if(isCreated == 'yes') {
                                                final result =
                                                await _auth.sendPasswordResetEmail(email: _emailControoler.text);

                                                print('Account creation successful');
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const  SnackBar(
                                                        backgroundColor: darkBrownColor,
                                                        content:  Text('Password reset email sent, check your mail')
                                                    )
                                                );
                                              }
                                              else {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                _methodsHandler.showAlertDialog(
                                                    context, 'Sorry', 'User Not Found');
                                              }
                                            }



                                          }
                                          on FirebaseAuthException catch (e)
                                          {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            print(e.code);
                                            switch (e.code) {
                                              case 'invalid-email':
                                                _methodsHandler.showAlertDialog(context,
                                                    'Sorry', 'Invalid Email Address');

                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                break;
                                              case 'wrong-password':
                                                _methodsHandler.showAlertDialog(
                                                    context, 'Sorry', 'Wrong Password');
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                break;
                                              case 'user-not-found':
                                                _methodsHandler.showAlertDialog(
                                                    context, 'Sorry', 'User Not Found');
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                break;
                                              case 'user-disabled':
                                                _methodsHandler.showAlertDialog(
                                                    context, 'Sorry', 'User Disabled');
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                break;
                                            }
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }

                                        }
                                      }


                                    }, child: Text('Send Email', style: buttonStyle)),
                              ),
                            ),
                            SizedBox(
                              height: size.height*0.1,
                            ),

                          ],
                        ),

                      ),


                    ],),
                ),
              ),


            ],),




        ),
      ),
    );

  }
}
