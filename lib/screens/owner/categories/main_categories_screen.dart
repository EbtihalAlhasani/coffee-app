import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/owner/categories/add_categories_screen.dart';
import 'dart:math' as math;


class MainCategoriesScreen extends StatefulWidget {

  const MainCategoriesScreen({Key? key,}) : super(key: key);

  @override
  _MainCategoriesScreenState createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
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
          "Categories",
          style: titleWhite,
        ),
        centerTitle: true,
      ),
      floatingActionButton:  FloatingActionButton(
        elevation: 0.0,
        child: Icon(Icons.add),
        backgroundColor: lightBrownColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddCategoryScreen(
                     docId: '',
                    categoryName: '',
                    categoryImage: '',
                    status: 'Add',
                  )));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
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
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: darkBrownColor),
                            borderRadius: BorderRadius.circular(10),
                            // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                            color: darkBrownColor,
                            gradient:  LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors:<Color>[darkBrownColor.withOpacity(0.5), darkBrownColor,]
                              // <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
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
                                  height: size.height * 0.1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),),
                                    child: Image.network( snapshot.data!.docs[index]["categoryImage"].toString()
                                    , fit: BoxFit.cover,
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
                                                    ["categoryName"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle( fontFamily: "Poppins",
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            // color: Colors.greenAccent,
                                            // width: size.width * 0.27,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [


                                                      GestureDetector(
                                                          onTap:() {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext context) => AddCategoryScreen(
                                                                      docId: snapshot.data!.docs[index].id.toString(),
                                                                      categoryName: snapshot.data!.docs[index]["categoryName"].toString(),
                                                                      categoryImage: snapshot.data!.docs[index]["categoryImage"].toString(),
                                                                      status: 'update',
                                                                    )));
                                                          },
                                                          child: Icon(Icons.edit, size: 25,color: Colors.white,)),
                                                      SizedBox(width: 10,),
                                                      GestureDetector(
                                                          onTap:() {

                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title:
                                                                  const Text('Delete'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(16.0),
                                                                            child: const Text('Cancel', style: TextStyle( fontFamily: "Poppins",color: whiteColor),),
                                                                          )),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () async {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            "Categories")
                                                                            .doc(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id
                                                                            .toString())
                                                                            .delete()
                                                                            .whenComplete(
                                                                                () {
                                                                              Navigator.of(
                                                                                  context)
                                                                                  .pop();
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                  const SnackBar(
                                                                                      backgroundColor: darkBrownColor,
                                                                                      content:  Text('Successfully Deleted',style: TextStyle( fontFamily: "Poppins",color: whiteColor),)
                                                                                  )
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(16.0),
                                                                            child: const Text('Delete', style: TextStyle( fontFamily: "Poppins",color: whiteColor),),
                                                                          )),
                                                                    ),
                                                                  ],
                                                                  content: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisSize:
                                                                    MainAxisSize.min,
                                                                    children: [
                                                                      const Text(
                                                                          'Are you sure you want to delete?'),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );

                                                          },
                                                          child: Icon(Icons.delete, size: 25,color: Colors.white,)),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
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
    );
  }
}
