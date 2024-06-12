import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class AdminMonitoringScreen extends StatefulWidget {
  const AdminMonitoringScreen({Key? key}) : super(key: key);

  @override
  _AdminMonitoringScreenState createState() => _AdminMonitoringScreenState();
}

class _AdminMonitoringScreenState extends State<AdminMonitoringScreen> {
  final TextEditingController _coffeeShopNameControler =
      TextEditingController();
  final TextEditingController _addressControler = TextEditingController();
  final TextEditingController _contactNumberControler = TextEditingController();
  int selectedQuantity = 0;
  bool _isLoading = false;
  String userType = '', email = '', uid = '', name = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _groupValue = -1;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      userType = '';
      email = '';
      uid = '';
    });
    //if(widget.userType == 'Users' || widget.userType == 'Farmer') {
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: milkyColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: darkBrownColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Monitor Quantity',
          style: titleWhite,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _coffeeShopNameControler,
              keyboardType: TextInputType.name,
              style: TextStyle( fontFamily: "Poppins",
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkGreyTextColor1, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "",
                hintStyle: TextStyle( fontFamily: "Poppins",
                  color: Colors.grey,
                  fontSize: 16,
                  
                  fontWeight: FontWeight.w400,
                ),
                labelText: 'Coffee Shop Name',
                //lable style
                labelStyle: TextStyle( fontFamily: "Poppins",
                  color: darkBrownColor,
                  fontSize: 16,
                  
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _addressControler,
              keyboardType: TextInputType.name,
              style: TextStyle( fontFamily: "Poppins",
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkGreyTextColor1, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "",
                hintStyle: TextStyle( fontFamily: "Poppins",
                  color: Colors.grey,
                  fontSize: 16,
                  
                  fontWeight: FontWeight.w400,
                ),
                labelText: 'Address',
                //lable style
                labelStyle: TextStyle( fontFamily: "Poppins",
                  color: darkBrownColor,
                  fontSize: 16,
                  
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _contactNumberControler,
              keyboardType: TextInputType.number,
              style: TextStyle( fontFamily: "Poppins",
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkGreyTextColor1, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "",
                hintStyle: TextStyle( fontFamily: "Poppins",
                  color: Colors.grey,
                  fontSize: 16,
                  
                  fontWeight: FontWeight.w400,
                ),
                labelText: 'Contact Number',
                //lable style
                labelStyle: TextStyle( fontFamily: "Poppins",
                  color: darkBrownColor,
                  fontSize: 16,
                  
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              "The Amount of Coffee Waste in Shop",
              style: TextStyle( fontFamily: "Poppins",
                  fontWeight: FontWeight.w600, fontSize: 16, color: textColor),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('5 KG'),
                  leading: Radio<int>(
                    value: 1,
                    activeColor: darkBrownColor,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = 5;
                        _groupValue = value ?? -1;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('10 KG'),
                  leading: Radio<int>(
                    value: 2,
                    activeColor: darkBrownColor,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = 10;
                        _groupValue = value ?? -1;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('15 KG'),
                  leading: Radio<int>(
                    value: 3,
                    activeColor: darkBrownColor,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = 15;
                        _groupValue = value ?? -1;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('20 KG'),
                  leading: Radio<int>(
                    value: 4,
                    activeColor: darkBrownColor,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = 20;
                        _groupValue = value ?? -1;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: size.height * 0.05,
                    width: size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          validateFields();

                        },
                        style: ElevatedButton.styleFrom(
                          primary: darkBrownColor,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text("Send", style: subtitleWhite)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "More? Scan the QR code",
                    style: TextStyle( fontFamily: "Poppins",
                        fontWeight: FontWeight.w600, fontSize: 16, color: textColor),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Image.asset("assets/images/qr.png", height: 150,),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validateFields() {
    if (_coffeeShopNameControler.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: darkBrownColor,
          content: Text('Enter Coffee Shop Name')));
    } else if (_addressControler.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: darkBrownColor,
          content: Text('Enter Coffee Shop Address')));
    } else if (_contactNumberControler.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: darkBrownColor,
          content: Text('Enter Contact Number')));
    } else if (selectedQuantity == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: darkBrownColor,
          content: Text('Select amount of coffee waste')));
    }
    else {
      FirebaseFirestore.instance
          .collection("coffeewaste")
          .add({
        "coffeeShopName": _coffeeShopNameControler.text,
        "address": _addressControler.text,
        "contactNumber": _contactNumberControler.text,
        "quantity": selectedQuantity,
      }).then((value) {
        print(value);
        Navigator.pop(context, "added");
      });
    }
  }
}
