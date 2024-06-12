
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/screens/owner/categories/main_categories_screen.dart';
import 'package:omani_agriculture_app/screens/owner/products/main_products_screen.dart';
import 'package:omani_agriculture_app/screens/owner/recyclingInfo/recycling_info_screen.dart';
import 'package:omani_agriculture_app/screens/owner/users/main_users_view_screen.dart';
import 'package:omani_agriculture_app/screens/order/admin_order_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  final String userType;

  const OwnerHomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _OwnerHomeScreenState createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  List<String> categories = [];

  int y=0;
  String name = '' , email = '',
      uid = '',
      users = '',
      orders = '',
      products = '',
      category = '';
  String text = '';
 // final FirebaseAuth _auth = FirebaseAuth.instance;
  String subject = '';
 // MethodsHandler _methodsHandler = MethodsHandler();
  bool isloading = true;

  List<Product> _categories = [

    Product(
        title: 'Orders',
        sale: 'Sale',
        isNew: '',
        quantity: '330g',
        ruppes: 'AED3.81',
        addToCart: 0,
        id: '',
        favorite: false,
        image: 'assets/images/orders.png'),

    Product(
      title: 'Products',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/img_products.png',
      favorite: false,
    ),
    Product(
        favorite: false,
        addToCart: 0,
        title: 'Recyling Info',
        sale: 'Sale',
        isNew: '',
        quantity: '330g',
        ruppes: 'AED3.81',
        id: '',
        image: 'assets/images/recycle.png'),
    Product(
        favorite: false,
        addToCart: 0,
        title: 'Categories',
        sale: 'Sale',
        isNew: '',
        quantity: '330g',
        ruppes: 'AED3.81',
        id: '',
        image: 'assets/images/Categories.png'),
  ];


  List<String> imgList = [
    "assets/images/slider1.webp",
    "assets/images/slider2.webp",
    "assets/images/slider3.jpeg",
    "assets/images/slider4.webp",
  ];

  List<Widget> imageSliders = [];

  getData() {

    setState(() {
      y=1;
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

    setState(() {

      isloading = false;
      y=0;
      users = '0';
      orders = '0';
      products = '0';
      category = '0';
    });
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(y==0) {
      getData();
    }
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: showExitPopup,

      child: Scaffold(
          backgroundColor: milkyColor,
          resizeToAvoidBottomInset: false,

          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: secondaryColor1, size: 25),

            elevation: 1,
            backgroundColor: darkBrownColor,//primaryColor1,
            title: Image.asset('assets/images/logo.png', color: Colors.white, fit: BoxFit.scaleDown,height: 50,),
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
                          enlargeCenterPage: true,
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
                        GridView.builder(
                            padding: EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                crossAxisCount: 2,
                                mainAxisExtent: 170,
                                mainAxisSpacing: 10),
                            itemCount: _categories
                                .length, //snapshot.data!.docs.length,//myProducts.length,
                            itemBuilder: (BuildContext ctx, index1) {
                              return GestureDetector(
                                onTap: () {
                                  print(index1.toString());
                                  if(index1 == 0) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => AdminOrderScreen(),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(
                                                opacity: anim, child: child),
                                        transitionDuration: Duration(
                                            milliseconds: 100),
                                      ),
                                    ).then((value) {
                                      getData();
                                      setState(() {

                                      });

                                    });
                                  }
                                  else if(index1 == 1) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => MainProductsScreen(list: categories),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 100),
                                      ),
                                    ).then((value) {
                                      getData();
                                      setState(() {

                                      });
                                    });
                                  }
                                  else if(index1 == 2) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => RecyclingInfoScreen2(),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(
                                                opacity: anim, child: child),
                                        transitionDuration: Duration(
                                            milliseconds: 100),
                                      ),
                                    ).then((value) {
                                      getData();
                                      setState(() {

                                      });
                                    });
                                  }
                                  else if(index1 == 3) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => MainCategoriesScreen(),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 100),
                                      ),
                                    ).then((value) {
                                      getData();
                                      setState(() {

                                      });
                                    });
                                  }

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
                                        colors:
                                        index1 == 0 ? <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor,] :
                                        index1 == 1 ? <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor] :
                                        index1 == 2 ? <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor] :
                                        <Color>[darkBrownColor.withOpacity(0.5), darkBrownColor],
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
                                                _categories[index1].image.toString(),
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

                                      // Center(
                                      //     child: Container(
                                      //       decoration: BoxDecoration(
                                      //         shape: BoxShape.circle,
                                      //         color: whiteColor,
                                      //         boxShadow: [
                                      //           BoxShadow(
                                      //             color: darkBrownColor
                                      //                 .withOpacity(0.4),
                                      //             spreadRadius: 1.2,
                                      //             blurRadius: 0.8,
                                      //             offset: Offset(0,
                                      //                 0), // changes position of shadow
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.all(8.0),
                                      //         child: Text(
                                      //           index1 == 0 ? orders.toString() :
                                      //           index1 == 1 ? products.toString() :
                                      //           index1 == 2 ? users.toString() :
                                      //           category.toString(),
                                      //           style: TextStyle( fontFamily: "Poppins",fontSize: 15,color:
                                      //           index1 == 0 ? darkBrownColor  :
                                      //           index1 == 1 ? darkBrownColor  :
                                      //           index1 == 2 ? darkBrownColor  :
                                      //           darkBrownColor,fontWeight: FontWeight.bold,),
                                      //           textAlign: TextAlign.center,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),

                                        Center(
                                          child: Text(
                                            _categories[index1].title.toString(),
                                            style: TextStyle( fontFamily: "Poppins",fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
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





      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await
    showDialog(
      //show confirm dialogue
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
