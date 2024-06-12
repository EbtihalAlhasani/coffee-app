import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/owner/coffeewaste/coffee_waste_screen.dart';
import 'package:omani_agriculture_app/screens/owner/ownerHomeScreen/owner_home_screen.dart';
import 'package:omani_agriculture_app/screens/profile/profile_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavBarOwnerScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subTitle;

  const AppBottomNavBarOwnerScreen({Key? key, required this.index, required this.title, required this.subTitle,}) : super(key: key);

  @override
  _AppBottomNavBarOwnerScreenState createState() => _AppBottomNavBarOwnerScreenState();
}

class _AppBottomNavBarOwnerScreenState extends State<AppBottomNavBarOwnerScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    //  HomeScreen(),
    // BookingScreen(),
    // ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('customerAccessToken');
    print( _pref.getString('customerAccessToken'));

    print('adminAccessToken');
    print( _pref.getString('adminAccessToken'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('UserType');
    setState(() {
      _pages = [
        OwnerHomeScreen(userType: widget.title,),
        CoffeeWasteScreen(),
        ProfileScreen(userType: widget.title,),
      ];
    });
    print(widget.title.toString());
  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //getToken();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        // backgroundColor: milkyColor,
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.white,
          inactiveColor: lightBrownColor,
          currentIndex: _selectedIndex,
          backgroundColor: darkBrownColor,
          iconSize: 40,
          onTap: _onItemTapped,
          items: [
            orientation == Orientation.portrait
                ? BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                      //    _pages[0] = InstructorHomeScreen( instructorId: widget.subTitle,);
                    });
                  },
                  child: Icon(
                    Icons.home_outlined,
                    size: 25,
                    //color: Color(0xFF3A5A98),
                  ),
                ),
              ),
              label: 'Dashboard',
            )
                : BottomNavigationBarItem(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                          //  _pages[0] = HomeScreen();
                        });
                      },
                      child: Icon(
                        Icons.home_outlined,
                        size: 25,
                        //color: Color(0xFF3A5A98),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Home',
                    style: TextStyle( fontFamily: "Poppins",fontSize: 15),
                  )
                ],
              ),
            ),
            orientation == Orientation.portrait
                ? BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                      // _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                    });
                  },
                  child: Icon(
                    Icons.local_drink,
                    size: 25,
                  ),
                ),
              ),
              label: 'Coffee Collection',
            )
                : BottomNavigationBarItem(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                          //   _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                        });
                      },
                      child: Icon(
                        Icons.local_drink,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Coffee Collection',
                    style: TextStyle( fontFamily: "Poppins",fontSize: 15),
                  )
                ],
              ),
            ),
            orientation == Orientation.portrait
                ? BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                      // _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                    });
                  },
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 25,
                  ),
                ),
              ),
              label: 'Profile',
            )
                : BottomNavigationBarItem(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                          //   _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                        });
                      },
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle( fontFamily: "Poppins",fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                textStyle: TextStyle( fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: redColor,
                textStyle: TextStyle( fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

}
