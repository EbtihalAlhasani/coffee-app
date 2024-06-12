import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/screens/order/order_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottomNavBar/app_bottom_nav_bar_screen.dart';

class OrderScreen extends StatefulWidget {

  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? renterEmail = '', renterName = '', renterUid = '';
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getRenter() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    await FirebaseFirestore.instance.collection('Renter').doc(  prefs.getString('userId').toString()).get().then((value) {

      if(value != null) {
        setState(() {
          renterName = value['name'] ?? "";
          renterEmail = value['email'] ?? "";
          renterUid = value['uid'] ?? "";
        });
      }
    });

    print(renterName.toString() + ' name is here');
  }

  @override
  void initState() {
    // TODO: implement initState
    getRenter();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: milkyColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: darkBrownColor,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: milkyColor,
              dividerColor: Colors.white,
              indicatorColor: Colors.white,
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(text: 'New',),
                Tab(text: 'Approved',),
              ],
            ),
            centerTitle: true,
            titleTextStyle: TextStyle( fontFamily: "Poppins",color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            title: Text('Orders'),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Orders").where("recipientUid", isEqualTo: _auth.currentUser!.uid.toString() ).where("orderStatus", isEqualTo: "Pending" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: darkBrownColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                name: snapshot.data!.docs[index]["recipientName"].toString(),
                                                email: snapshot.data!.docs[index]["recipientEmail"].toString(),
                                                orderId: snapshot.data!.docs[index]["orderId"].toString(),
                                                orderTotal: snapshot.data!.docs[index]["orderTotal"].toString(),
                                                payment: snapshot.data!.docs[index]["paymentMethod"].toString(),
                                                productsList: snapshot.data!.docs[index]["items"],
                                                address: snapshot.data!.docs[index]["deliveryAddress"].toString(),
                                                orderStatus:snapshot.data!.docs[index]["orderStatus"].toString(),
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.85,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          // color: redColor,
                                          width: size.width*0.3,
                                          height: size.height*0.12,
                                          child:  ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/images/order.png"
                                              , fit:
                                            BoxFit.cover,
                                              // width: 100,
                                              // height: 140,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //   color: redColor,
                                          //width: size.width*0.5,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,top: 8),
                                                      child: Text(
                                                        "OrderId : #" + snapshot.data!.docs[index]["orderId"].toString()
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Payment : " + snapshot.data!.docs[index]["paymentMethod"].toString()
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Total : ر.ع  " + snapshot.data!.docs[index]["orderTotal"].toString() + " "
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Total Items : " + snapshot.data!.docs[index]["orderTotalItems"].toString() + " "
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),



                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color:
                                                          snapshot.data!.docs[index]["orderStatus"].toString() == 'Pending' ? Colors.lightBlueAccent :
                                                          darkBrownColor,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["orderStatus"].toString() == 'Pending' ? 'Order Pending' : 'Pending'

                                                            , style: TextStyle( fontFamily: "Poppins",
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Orders").where("recipientUid", isEqualTo: _auth.currentUser!.uid.toString() ).where("orderStatus", isEqualTo: "Approved" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: darkBrownColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                name: snapshot.data!.docs[index]["recipientName"].toString(),
                                                email: snapshot.data!.docs[index]["recipientEmail"].toString(),
                                                orderId: snapshot.data!.docs[index]["orderId"].toString(),
                                                orderTotal: snapshot.data!.docs[index]["orderTotal"].toString(),
                                                payment: snapshot.data!.docs[index]["paymentMethod"].toString(),
                                                productsList: snapshot.data!.docs[index]["items"],
                                                address: snapshot.data!.docs[index]["deliveryAddress"].toString(),
                                                orderStatus:snapshot.data!.docs[index]["orderStatus"].toString(),

                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.85,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          // color: redColor,
                                          width: size.width*0.3,
                                          height: size.height*0.12,
                                          child:  ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              "assets/images/order.png"
                                              , fit:
                                            BoxFit.cover,
                                              // width: 100,
                                              // height: 140,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //   color: redColor,
                                          //width: size.width*0.5,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,top: 8),
                                                      child: Text(
                                                        "OrderId : #" + snapshot.data!.docs[index]["orderId"].toString()
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Payment : " + snapshot.data!.docs[index]["paymentMethod"].toString()
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Total : ر.ع  " + snapshot.data!.docs[index]["orderTotal"].toString() + " "
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Total Items : " + snapshot.data!.docs[index]["orderTotalItems"].toString() + " "
                                                        , style: TextStyle( fontFamily: "Poppins",
                                                          color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),



                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color:
                                                          snapshot.data!.docs[index]["orderStatus"].toString() == 'Approved' ?
                                                              Colors.green :

                                                          darkBrownColor,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["orderStatus"].toString() == 'Approved' ? 'Order Approved' : ''

                                                            , style: TextStyle( fontFamily: "Poppins",
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
