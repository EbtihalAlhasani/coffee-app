import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/screens/admin/adminMonitoring/admin_monitoring_screen.dart';
import 'package:omani_agriculture_app/screens/admin/products_screen.dart';
import 'package:omani_agriculture_app/screens/order/admin_order_screen.dart';
import 'package:omani_agriculture_app/screens/order/order_history_screen.dart';
import 'package:omani_agriculture_app/screens/owner/categories/main_categories_screen.dart';
import 'package:omani_agriculture_app/screens/owner/products/main_products_screen.dart';
import 'package:omani_agriculture_app/screens/owner/recyclingInfo/recycling_info_screen.dart';

import '../owner/ownerHomeScreen/owner_home_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key, required this.userType});

  final String userType;

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<String> categories = [];

  List<String> imgList = [
    "assets/images/slider1.webp",
    "assets/images/slider2.webp",
    "assets/images/slider3.jpeg",
    "assets/images/slider4.webp",
  ];

  List<Widget> imageSliders = [];
  String name = '' , email = '',
      uid = '',
      users = '',
      orders = '',
      products = '',
      category = '';
  bool isloading = true;
  MethodsHandler _methodsHandler = MethodsHandler();

  getData() {

    setState(() {
    int  y=1;
    });
    FirebaseFirestore.instance.collection('Users').get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          users = value.docs.length.toString();
        });

      }
    });

    FirebaseFirestore.instance.collection('Orders').where('orderStatus', isEqualTo:
    'Pending').get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          orders = value.docs.length.toString();
        });

      }
    });

    FirebaseFirestore.instance.collection('Products').get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          products = value.docs.length.toString();
        });

      }
    });

    FirebaseFirestore.instance.collection('Categories').get().then((value) {
      setState(() {
        categories.clear();
      });
      if(value.docs.isNotEmpty) {

        setState(() {
          category = value.docs.length.toString();
          categories.add('Select Category');
        });
        for(int i=0;i<value.docs.length;i++) {
          setState(() {
            categories.add(value.docs[i]['categoryName'].toString());
          });
        }

      }
    });
    setState(() {
      isloading = false;
    });
  }


  @override
  void initState() {
    imageSliders = imgList
        .map((item) => Container(
      child: Container(
        // margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(item, fit: BoxFit.cover, width: 500.0)),
      ),
    ))
        .toList();

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: milkyColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: secondaryColor1, size: 25),

          elevation: 1,
          backgroundColor: darkBrownColor,
          //primaryColor1,
          title: Image.asset(
            'assets/images/logo.png',
            color: Colors.white,
            fit: BoxFit.scaleDown,
            height: 50,
          ),
          centerTitle: true,
        ),
        body:
        SingleChildScrollView(
          child: Column(children: [


            isloading ? Center(child: CircularProgressIndicator(color: primaryColor1,)) :
            Column(
              children: [
                SizedBox(height: 0.025 * size.height,),
                Container(
                    height: size.height * 0.25,
                    width: size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        // enlargeFactor: 0.75,
                      ),
                      items: imageSliders,
                    )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                  child: Column(
                    children: [
                      GridView.count(crossAxisCount: 2,
                          padding: EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => ProductsScreen(list: categories),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 100),
                                  ),
                                ).then((value) {
                                  getData();
                                  setState(() {

                                  });
                                });
                                },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //width: size.width * 0.3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white,
                                    gradient:  LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor1
                                            .withOpacity(0.4),
                                        spreadRadius: 1.2,
                                        blurRadius: 0.8,
                                        offset: Offset(0,
                                            0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Container(

                                            child: Image.asset(
                                              "assets/images/img_products.png",
                                              // _categories[index]
                                              //     .image
                                              //     .toString(),
                                              fit: BoxFit.scaleDown,
                                              height: 75,
                                              width: 75,
                                            ),
                                          )),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Center(
                                        child: Text(
                                          "Products",
                                          style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(AdminMonitoringScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //width: size.width * 0.3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white,
                                    gradient:  LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor1
                                            .withOpacity(0.4),
                                        spreadRadius: 1.2,
                                        blurRadius: 0.8,
                                        offset: Offset(0,
                                            0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Container(

                                            child: Image.asset(
                                             "assets/images/kpi.png",
                                              // _categories[index]
                                              //     .image
                                              //     .toString(),
                                              fit: BoxFit.scaleDown,
                                              height: 75,
                                              width: 75,
                                            ),
                                          )),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Center(
                                        child: Text(
                                         "Monitor Quantity",
                                          style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(RecyclingInfoScreen2());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //width: size.width * 0.3,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white,
                                    gradient:  LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor1
                                            .withOpacity(0.4),
                                        spreadRadius: 1.2,
                                        blurRadius: 0.8,
                                        offset: Offset(0,
                                            0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Container(

                                            child: Image.asset(
                                              "assets/images/recycle.png",
                                              // _categories[index]
                                              //     .image
                                              //     .toString(),
                                              fit: BoxFit.scaleDown,
                                              height: 75,
                                              width: 75,
                                            ),
                                          )),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Center(
                                        child: Text(
                                          "Recycling Info",
                                          style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //     _methodsHandler.signOut(context);
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Container(
                            //       //width: size.width * 0.3,
                            //       alignment: Alignment.center,
                            //       decoration: BoxDecoration(
                            //         //shape: BoxShape.circle,
                            //         borderRadius: BorderRadius.circular(0),
                            //         color: Colors.white,
                            //         gradient:  LinearGradient(
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight,
                            //           colors: <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor],
                            //         ),
                            //         boxShadow: [
                            //           BoxShadow(
                            //             color: primaryColor1
                            //                 .withOpacity(0.4),
                            //             spreadRadius: 1.2,
                            //             blurRadius: 0.8,
                            //             offset: Offset(0,
                            //                 0), // changes position of shadow
                            //           ),
                            //         ],
                            //       ),
                            //       child: Column(
                            //         crossAxisAlignment:
                            //         CrossAxisAlignment.center,
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Center(
                            //               child: Container(
                            //
                            //                 child: Image.asset(
                            //                   "assets/images/shutdown.png",
                            //                   // _categories[index]
                            //                   //     .image
                            //                   //     .toString(),
                            //                   fit: BoxFit.scaleDown,
                            //                   height: 75,
                            //                   width: 75,
                            //                 ),
                            //               )),
                            //           SizedBox(
                            //             height: size.height * 0.01,
                            //           ),
                            //           Center(
                            //             child: Text(
                            //               "Logout",
                            //               style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                            //               textAlign: TextAlign.center,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),



          ],),
        )
    );
  }
}
