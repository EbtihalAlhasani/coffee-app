import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omani_agriculture_app/screens/categoryItems/category_items_screen.dart';
import 'package:omani_agriculture_app/screens/monitoring/monitoring_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/model/getx_model.dart';
import 'package:omani_agriculture_app/screens/user/orderingDetail/user_product_odering_screen.dart';

import '../../admin/products_screen.dart';
import '../../owner/recyclingInfo/recycling_info_screen.dart';

class UserHomeScreen extends StatefulWidget {
  final String userType;

  const UserHomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final cartController = Get.find<AddToCartController>();
  String name = '', email = '', uid = '', userType = '';
  String text = '', category = '';
  int current = 0;
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> categories = [];

  List<String> imgList = [
    "assets/images/slider1.webp",
    "assets/images/slider2.webp",
    "assets/images/slider3.jpeg",
    "assets/images/slider4.webp",
  ];

  List<Widget> imageSliders = [];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });
      FirebaseFirestore.instance
          .collection(userType)
          .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
          .get()
          .then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });
    } else {
      print('Starting usertype');
    }

    FirebaseFirestore.instance.collection('Categories').get().then((value) {
      setState(() {
        categories.clear();
      });
      if (value.docs.isNotEmpty) {
        setState(() {
          category = value.docs.length.toString();
          categories.add('Select Category');
        });
        for (int i = 0; i < value.docs.length; i++) {
          setState(() {
            categories.add(value.docs[i]['categoryName'].toString());
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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

    cartController.fetchCartItems();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: milkyColor,
        appBar: AppBar(
            leading: Container(),
            backgroundColor: darkBrownColor,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Image.asset(
              'assets/images/logo.png',
              color: Colors.white,
              fit: BoxFit.scaleDown,
              height: 50,
            )),
        // drawer: Drawer(
        //   backgroundColor: milkyColor, //Colors.white,
        //   child: ListView(
        //     // Important: Remove any padding from the ListView.
        //     padding: EdgeInsets.zero,
        //     children: [
        //       // SizedBox(
        //       //   height: 20,
        //       // ),
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
        //           gradient: LinearGradient(begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //             stops: [
        //               0.1,
        //               0.9
        //             ], colors: [
        //               darkBrownColor,
        //               lightBrownColor,
        //             ],
        //           ),
        //         ),
        //         margin: EdgeInsets.zero,
        //         child: Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               CircleAvatar(
        //                 radius: 40,
        //                 backgroundImage: AssetImage(
        //                     'assets/images/coffee_header.jpeg'),
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Text(
        //                 name,
        //                 style: TextStyle( fontFamily: "Poppins",
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 17,
        //                 ),
        //               ),
        //               Text(
        //                 email,
        //                 style: TextStyle( fontFamily: "Poppins",
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.w400,
        //                   fontSize: 12,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding:
        //         const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
        //         child: ListTile(
        //           shape: RoundedRectangleBorder(
        //             //<-- SEE HERE
        //             side: BorderSide(width: 1, color: whiteColor),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           tileColor: whiteColor,
        //           leading: Container(
        //               width: 30,
        //               height: 30,
        //               //devSize.height*0.05,
        //               child: Image.asset('assets/images/orders.png', fit: BoxFit.scaleDown,
        //                 width: 30,
        //                 height: 30,
        //
        //               )
        //
        //             // Icon(
        //             //   Icons.local_fire_department,
        //             //   color: Colors.white,
        //             //   size: 20,
        //             // )
        //
        //           ),
        //           trailing: Icon(
        //             Icons.arrow_forward_ios,
        //             color: Colors.black,
        //             size: 15,
        //           ),
        //           title: Text('Order History',),
        //           onTap: () async {
        //             Navigator.push(
        //               context,
        //               PageRouteBuilder(
        //                 pageBuilder: (c, a1, a2) => CategoryItemScreen(category: 'Seeds'),
        //                 transitionsBuilder: (c, anim, a2, child) =>
        //                     FadeTransition(opacity: anim, child: child),
        //                 transitionDuration: Duration(milliseconds: 100),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //
        //       Padding(
        //         padding:
        //         const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
        //         child: ListTile(
        //           shape: RoundedRectangleBorder(
        //             //<-- SEE HERE
        //             side: BorderSide(width: 1, color: whiteColor),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           tileColor: whiteColor,
        //           leading: Container(
        //               width: 30,
        //               height: 30,
        //               //devSize.height*0.05,
        //               child: Image.asset('assets/images/recycle.png', fit: BoxFit.scaleDown,
        //                 width: 30,
        //                 height: 30,
        //
        //               )
        //
        //             // Icon(
        //             //   Icons.local_fire_department,
        //             //   color: Colors.white,
        //             //   size: 20,
        //             // )
        //
        //           ),
        //           trailing: Icon(
        //             Icons.arrow_forward_ios,
        //             color: Colors.black,
        //             size: 15,
        //           ),
        //           title: Text('Recycling Info',),
        //           onTap: () async {
        //             Navigator.push(
        //               context,
        //               PageRouteBuilder(
        //                 pageBuilder: (c, a1, a2) => CategoryItemScreen(category: 'Plants'),
        //                 transitionsBuilder: (c, anim, a2, child) =>
        //                     FadeTransition(opacity: anim, child: child),
        //                 transitionDuration: Duration(milliseconds: 100),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //
        //       Padding(
        //         padding:
        //         const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
        //         child: ListTile(
        //           shape: RoundedRectangleBorder(
        //             //<-- SEE HERE
        //             side: BorderSide(width: 1, color: whiteColor),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           tileColor: whiteColor,
        //           leading: Container(
        //               width: 35,
        //               height: 35,
        //               //devSize.height*0.05,
        //               child: Image.asset('assets/images/crops.png', fit: BoxFit.scaleDown,
        //                 width: 35,
        //                 height: 35,
        //
        //               )
        //
        //             // Icon(
        //             //   Icons.local_fire_department,
        //             //   color: Colors.white,
        //             //   size: 20,
        //             // )
        //
        //           ),
        //           trailing: Icon(
        //             Icons.arrow_forward_ios,
        //             color: Colors.black,
        //             size: 15,
        //           ),
        //           title: Text('Contact Us',),
        //           onTap: () async {
        //             Navigator.push(
        //               context,
        //               PageRouteBuilder(
        //                 pageBuilder: (c, a1, a2) => CategoryItemScreen(category: 'Agriculture Tools'),
        //                 transitionsBuilder: (c, anim, a2, child) =>
        //                     FadeTransition(opacity: anim, child: child),
        //                 transitionDuration: Duration(milliseconds: 100),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //
        //       Padding(
        //         padding:
        //         const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
        //         child: ListTile(
        //           shape: RoundedRectangleBorder(
        //             //<-- SEE HERE
        //             side: BorderSide(width: 1, color: whiteColor),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           tileColor: whiteColor,
        //           leading: Container(
        //               width: 30,
        //               height: 30,
        //               //devSize.height*0.05,
        //               child: Image.asset('assets/images/shutdown.png', fit: BoxFit.scaleDown,
        //                 width: 30,
        //                 height: 30,
        //
        //               )
        //
        //             // Icon(
        //             //   Icons.local_fire_department,
        //             //   color: Colors.white,
        //             //   size: 20,
        //             // )
        //
        //           ),
        //           trailing: Icon(
        //             Icons.arrow_forward_ios,
        //             color: Colors.black,
        //             size: 15,
        //           ),
        //           title: Text('Logout',),
        //           onTap: () async {
        //             _methodsHandler.signOut(context);
        //           },
        //         ),
        //       ),
        //
        //     ],
        //   ),
        // ),
        // appBar: AppBar(
        //
        //   iconTheme: IconThemeData(color: secondaryColor1, size: 25),
        //   automaticallyImplyLeading: false,
        //   elevation: 1,
        //   backgroundColor: primaryColor,
        //   title:
        //   Text('Omani Attire', style: body1White,),
        //
        //   //Image.asset('assets/images/transparent_logo.png', fit: BoxFit.scaleDown,width: 230,),
        //   centerTitle: true,
        // ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                  height: size.height * 0.25,
                  width: size.width,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      // enlargeFactor: 0.75,
                    ),
                    items: imageSliders,
                  )),

              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    GridView.count(
                        crossAxisCount: 2,
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      ProductsScreen(list: categories),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      Duration(milliseconds: 100),
                                ),
                              ).then((value) {
                                getData();
                                setState(() {});
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
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      darkBrownColor.withOpacity(0.5),
                                      darkBrownColor
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor1.withOpacity(0.4),
                                      spreadRadius: 1.2,
                                      blurRadius: 0.8,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
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
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      darkBrownColor.withOpacity(0.5),
                                      darkBrownColor
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor1.withOpacity(0.4),
                                      spreadRadius: 1.2,
                                      blurRadius: 0.8,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
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

              // AnimatedSmoothIndicator(
              //   activeIndex: current,
              //   count: 3,//pages.length,
              //   effect: const JumpingDotEffect(
              //       dotHeight: 10,
              //       dotWidth: 10,
              //       jumpScale: .7,
              //       verticalOffset: 20,
              //       activeDotColor: darkPeachColor,
              //       dotColor: Colors.grey),
              // ),
/*
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: size.width * .9,
                padding: EdgeInsets.only(left: 10, right: 0),
                child: Text(
                  'Select Category',
                  style: body1Black,
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              Container(
                //  color: Colors.red,
                // height: size.height * .22,
                width: size.width * .95,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Categories")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: primaryColor,
                      ));
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isEmpty) {
                      // got data from snapshot but it is empty

                      return Center(child: Text("No Data Found"));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          //  color: Color(0xFFFBFBFB),
                          // height: size.height*0.66,
                          child: GridView.builder(
                              padding: EdgeInsets.only(top: 8),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: size.height * 0.22,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                                // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses!.length);
                                // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                                // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses![index].verseRecording.toString() + " surah record");

                                return widget.userType == "Users" &&
                                        snapshot.data!
                                                .docs[index]["categoryName"]
                                                .toString() ==
                                            "Monitoring"
                                    ? SizedBox()
                                    : InkWell(
                                        onTap: () {
                                         */ /* if (index == 3) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MonitoringScreen()));
                                          } else */ /*{
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (c, a1, a2) =>
                                                    CategoryItemScreen(
                                                  category: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ["categoryName"]
                                                      .toString(),
                                                ),
                                                transitionsBuilder:
                                                    (c, anim, a2, child) =>
                                                        FadeTransition(
                                                            opacity: anim,
                                                            child: child),
                                                transitionDuration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Container(
                                            // height: size.height*0.25,
                                            width: size.width * 0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //       color: lightButtonGreyColor,
                                              //       spreadRadius: 2,
                                              //       blurRadius: 3)
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                              ["categoryImage"]
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      height: size.height * 0.15,
                                                      width: size.width * 0.3,
                                                      // height: 80,
                                                      // width: 80,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width * 0.4,
                                                    child: Center(
                                                      child: Text(
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                                ["categoryName"]
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle( fontFamily: "Poppins",
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              }),
                        ),
                      );
                    }
                  },
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              Container(
                // color: redColor,
                //  height: size.height * 0.5,
                width: size.width * .95,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Categories")
                      .snapshots(),
                  builder: (context, snapshotCategory) {
                    if (!snapshotCategory.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: primaryColor,
                      ));
                    } else if (snapshotCategory.hasData &&
                        snapshotCategory.data!.docs.isEmpty) {
                      // got data from snapshot but it is empty

                      return Center(child: Text("No Data Found"));
                    } else {
                      return Center(
                        child: Container(
                          width: size.width * 0.95,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshotCategory.data!.docs.length,
                              //_categories.length,
                              shrinkWrap: true,
                              itemBuilder: (context, int categoryIndex) {
                                return (widget.userType == "Users" ||
                                            widget.userType == "Farmer") &&
                                        snapshotCategory
                                                .data!
                                                .docs[categoryIndex]
                                                    ["categoryName"]
                                                .toString() ==
                                            "Monitoring"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Container(
                                            width: size.width * .9,
                                            child: Text(
                                              snapshotCategory
                                                  .data!
                                                  .docs[categoryIndex]
                                                      ["categoryName"]
                                                  .toString(),
                                              style: body1Black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Container(
                                            height: size.height * .3,
                                            width: size.width * .95,
                                            child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("Products")
                                                  .where("category",
                                                      isEqualTo: snapshotCategory
                                                          .data!
                                                          .docs[categoryIndex]
                                                              ["categoryName"]
                                                          .toString())
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                    color: primaryColor,
                                                  ));
                                                } else if (snapshot.hasData &&
                                                    snapshot
                                                        .data!.docs.isEmpty) {
                                                  // got data from snapshot but it is empty

                                                  return Center(
                                                      child: Text(
                                                          "No Data Found"));
                                                } else {
                                                  return Center(
                                                    child: Container(
                                                      width: size.width * 0.95,
                                                      height: size.height * 0.25,
                                                      child: ListView.builder(
                                                          // physics:
                                                          //     NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: snapshot
                                                              .data!
                                                              .docs
                                                              .length,
                                                          //_categories.length,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,
                                                              int index) {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      PageRouteBuilder(
                                                                        pageBuilder: (c, a1, a2) => UserProductOrderingScreen(
                                                                            docId:
                                                                                snapshot.data!.docs[index].id.toString(),
                                                                            productName: snapshot.data!.docs[index]["productName"].toString(),
                                                                            productPrice: snapshot.data!.docs[index]["productPrice"].toString(),
                                                                            productCode: snapshot.data!.docs[index]["productCode"].toString(),
                                                                            productImage: snapshot.data!.docs[index]["productImage"].toString(),
                                                                            productCategory: snapshot.data!.docs[index]["category"].toString()),
                                                                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(
                                                                            opacity:
                                                                                anim,
                                                                            child:
                                                                                child),
                                                                        transitionDuration:
                                                                            Duration(milliseconds: 0),
                                                                      ),
                                                                    ).then(
                                                                        (value) {
                                                                      cartController
                                                                          .fetchCartItems();
                                                                      setState(
                                                                          () {});
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                          .white,
                                                                      // boxShadow: [
                                                                      //   BoxShadow(
                                                                      //     color:
                                                                      //         Color(0xff000000).withOpacity(0.1),
                                                                      //     spreadRadius:
                                                                      //         1,
                                                                      //     blurRadius:
                                                                      //         1,
                                                                      //     offset: Offset(
                                                                      //         0,
                                                                      //         0), // changes position of shadow
                                                                      //   ),
                                                                      // ],
                                                                    ),
                                                                    width: size
                                                                            .width *
                                                                        0.5,
                                                                        // height: size.height * 0.15,
                                                                        child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(4),
                                                                                  //   color: Colors.green,
                                                                                ),
                                                                                height: size.height * 0.15,
                                                                                child: Center(
                                                                                    child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                                                                                  child: Image.network(
                                                                                    snapshot.data!.docs[index]["productImage"].toString(),
                                                                                    width: size.width * 0.3,
                                                                                    height: size.height * 0.15,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                )),
                                                                              ),
                                                                              Container(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Container(
                                                                                      decoration: BoxDecoration(color: redColor, borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                        child: Text('sale', style: caption1White),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                                                                                                    alignment:
                                                                          Alignment.center,
                                                                                                                                                    child:
                                                                          Container(
                                                                        child: Text(
                                                                          snapshot.data!.docs[index]["productName"].toString(),
                                                                          style: body3Black,
                                                                          textAlign: TextAlign.center,
                                                                          maxLines: 2,
                                                                        ),
                                                                                                                                                    ),
                                                                                                                                                  ),
                                                                        Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: 4,
                                                                              bottom: 10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                child: Text('ر.ع. ' + snapshot.data!.docs[index]["productPrice"].toString(), style: caption3Red),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        // Padding(
                                                                        //   padding: const EdgeInsets.only(bottom: 10),
                                                                        //   child: Container(
                                                                        //     height: 30,
                                                                        //     decoration: BoxDecoration(
                                                                        //         borderRadius: BorderRadius.circular(10),
                                                                        //         color: primaryColor1
                                                                        //     ),
                                                                        //     child: Padding(
                                                                        //       padding: const EdgeInsets.all(8.0),
                                                                        //       child: Text('Add to cart', style: TextStyle( fontFamily: "Poppins",color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                                                                        //     ),
                                                                        //   ),
                                                                        // ),

                                                                        // Row(
                                                                        //   mainAxisAlignment:
                                                                        //   MainAxisAlignment
                                                                        //       .center,
                                                                        //   children: [
                                                                        //     MaterialButton(
                                                                        //       onPressed: () async {
                                                                        //         if (_newArrivalsProducts[
                                                                        //         index]
                                                                        //             .addToCart >=
                                                                        //             1) {
                                                                        //           setState(() {
                                                                        //             _newArrivalsProducts[
                                                                        //             index]
                                                                        //                 .addToCart = _newArrivalsProducts[
                                                                        //             index]
                                                                        //                 .addToCart -
                                                                        //                 1;
                                                                        //           });
                                                                        //         }
                                                                        //       },
                                                                        //       color:
                                                                        //       lightGreenColor,
                                                                        //       textColor:
                                                                        //       Colors.white,
                                                                        //       child: Icon(
                                                                        //         Icons.remove,
                                                                        //         size: 17,
                                                                        //         color: primaryColor,
                                                                        //       ),
                                                                        //       minWidth:
                                                                        //       size.width * 0.06,
                                                                        //       padding:
                                                                        //       EdgeInsets.zero,
                                                                        //       shape: CircleBorder(),
                                                                        //     ),
                                                                        //     Text(
                                                                        //         _newArrivalsProducts[
                                                                        //         index]
                                                                        //             .addToCart
                                                                        //             .toString(),
                                                                        //         style:
                                                                        //         caption1Black),
                                                                        //     MaterialButton(
                                                                        //       onPressed: () async {
                                                                        //         setState(() {
                                                                        //           _newArrivalsProducts[
                                                                        //           index]
                                                                        //               .addToCart =
                                                                        //               _newArrivalsProducts[
                                                                        //               index]
                                                                        //                   .addToCart +
                                                                        //                   1;
                                                                        //         });
                                                                        //       },
                                                                        //       color: primaryColor,
                                                                        //       textColor:
                                                                        //       Colors.white,
                                                                        //       child: Icon(
                                                                        //         Icons.add,
                                                                        //         size: 17,
                                                                        //       ),
                                                                        //       minWidth:
                                                                        //       size.width * 0.06,
                                                                        //       padding:
                                                                        //       EdgeInsets.zero,
                                                                        //       shape: CircleBorder(),
                                                                        //     ),
                                                                        //   ],
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ));
                                                          }),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                              }),
                        ),
                      );
                    }
                  },
                ),
              ),*/
            ],
          ),
        ));
  }
}

class Product {
  final String image;
  final String id;
  final String sale;
  final String isNew;
  final String title;
  final String quantity;
  final String ruppes;
  bool favorite;
  int addToCart;

  Product(
      {required this.title,
      required this.id,
      required this.sale,
      required this.isNew,
      required this.quantity,
      required this.ruppes,
      required this.image,
      required this.favorite,
      required this.addToCart});
}
