

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/getx_model.dart';
import 'package:omani_agriculture_app/model/product_model.dart';
import 'dart:math' as math;

import 'package:omani_agriculture_app/screens/detail/product_detail_screen.dart';
import 'package:omani_agriculture_app/screens/user/orderingDetail/user_product_odering_screen.dart';

class ProductsScreen extends StatefulWidget {
  final List<String> list;
  const ProductsScreen({super.key, required this.list});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final cartController = Get.put(AddToCartController());

  String dropdownvalue = 'Select Category';
  List items = [
    'Select Category',
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      dropdownvalue = 'Select Category';
      items = widget.list;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: milkyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: darkBrownColor,
        title: Text(
          "Products",
          style: titleWhite,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Container(

                height: size.height * 0.075,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: greyColor, width: 0.5),
                  color: whiteColor,
                ),
                width: size.width * 0.95,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: dropdownvalue,

                      hint: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Select',
                          style: TextStyle( fontFamily: "Poppins",
                              color: textColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                        ),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      isDense: true, // Reduces the dropdowns height by +/- 50%
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: greyColor,
                        ),
                      ),
                      items: items.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(item, style: body4Black),
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedItem) {
                        setState(() {
                          dropdownvalue = selectedItem.toString();
                        });
                      }
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),

          Container(
            height: size.height * 0.6,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Products").where("category" ,isEqualTo: dropdownvalue).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: primaryColor,
                      ));
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  // got data from snapshot but it is empty

                  return Center(child: Text("No Data Found"));
                } else {
                  return Center(
                    child: Container(
                      width: size.width * 0.95,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      UserProductOrderingScreen(
                                          docId: snapshot.data!.docs[index].id.toString(),
                                          productName: snapshot.data!.docs[index]["productName"].toString(),
                                          productPrice: snapshot.data!.docs[index]["productPrice"].toString(),
                                          productCode: snapshot.data!.docs[index]["productCode"].toString(),
                                          productImage:  snapshot.data!.docs[index]["productImage"].toString(),
                                          productCategory:  snapshot.data!.docs[index]["category"].toString()),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 0),
                                ),
                              ).then((value) {
                                cartController.fetchCartItems();
                                setState(() {

                                });
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 0, right: 0),
                              child: Container(
                                width: size.width * 0.95,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: primaryColor1),
                                  borderRadius: BorderRadius.circular(10),
                                  //   color: whiteColor
                                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                                  gradient:  LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors:

                                    <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                                  ),


                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0,bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // color: Colors.green,
                                        ),
                                        width: size.width * 0.25,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network( snapshot.data!.docs[index]["productImage"].toString()
                                            , fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        //  color: redColor,
                                        width: size.width * 0.65,

                                        child: Column(
                                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              children: [
                                                SizedBox(width: 8,),
                                                Container(
                                                  //  color: Colors.orange,
                                                  width: size.width * 0.4,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Container(
                                                        // color: Colors.yellow,
                                                        alignment: Alignment.topLeft,
                                                        child:  Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                          ["productName"]
                                                              .toString() ,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle( fontFamily: "Poppins",
                                                              color: secondaryColor1,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w700,
                                                              height: 1.5),
                                                        ),
                                                      ),
                                                      Container(
                                                        // color: Colors.yellow,
                                                        alignment: Alignment.topLeft,
                                                        child:  Text(
                                                          "Category: " + snapshot
                                                              .data!
                                                              .docs[index]
                                                          ["category"]
                                                              .toString() ,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle( fontFamily: "Poppins",
                                                              color: secondaryColor1,
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w500,
                                                              height: 1.5),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        // padding: EdgeInsets.only(
                                                        //     left: 7,
                                                        //     top: 4,
                                                        //     right: 10),
                                                        child:Text(
                                                            'ر.ع. ' +
                                                                snapshot.data!.docs[index]["productPrice"].toString(),
                                                            style:
                                                            caption3Red),

                                                      ),

                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  width: 1,
                                                  height: 40,
                                                  color: Colors.grey.withOpacity(0.3),
                                                ),
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        //Container(child: Text('AdminHome'),),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

        ],
      ),



    );
  }
}
