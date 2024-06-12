

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';

class CoffeeWasteScreen extends StatefulWidget {
  const CoffeeWasteScreen({super.key});

  @override
  State<CoffeeWasteScreen> createState() => _CoffeeWasteScreenState();
}

class _CoffeeWasteScreenState extends State<CoffeeWasteScreen> {
  var orders = FirebaseFirestore.instance.collection("coffeewaste").snapshots();

  @override
  Widget build(BuildContext context) {
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.81,
            child: StreamBuilder(
                stream: orders,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("Something went wrong",
                            style: TextStyle( fontFamily: "Poppins",

                            )));
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle( fontFamily: "Poppins",

                          ),
                        ));
                  } else if (snapshot.requireData.docChanges.isEmpty) {
                    return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle( fontFamily: "Poppins",

                          ),
                        ));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                tileColor: lightBrownColor.withOpacity(0.1),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Coffee Shop Name: " +
                                            snapshot.data!.docs[index]
                                            ["coffeeShopName"],
                                        style: const TextStyle( fontFamily: "Poppins",

                                        )),
                                    SizedBox(height: 3,),
                                    Text(
                                        "Coffee Shop Address: " +
                                            snapshot.data!.docs[index]
                                            ["address"],
                                        style: const TextStyle( fontFamily: "Poppins",

                                        )),
                                    SizedBox(height: 3,),
                                    Text(
                                        "Contact Number: " +
                                            snapshot.data!.docs[index]
                                            ["contactNumber"],
                                        style: const TextStyle( fontFamily: "Poppins",

                                        )),
                                    SizedBox(height: 3,),
                                    Text(
                                        "Quantity: " +
                                            snapshot.data!.docs[index]
                                            ["quantity"].toString() + "kg",
                                        style: const TextStyle( fontFamily: "Poppins",

                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                        child: Text('No Data Found',
                            style: TextStyle( fontFamily: "Poppins",

                            )));
                  }
                }),
          ),
        ]));
  }
}
