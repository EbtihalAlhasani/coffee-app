
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({Key? key}) : super(key: key);

  @override
  _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Qr Code Scanner',
          style: TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(
                'assets/images/arrow_back.png',
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
              ),
            )),
      ),

      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/qr.png',
                  height: 200,
                  // width: 200,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),

            SizedBox(
              height: size.height*0.05,
            ),

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
                      minimumSize: MaterialStateProperty.all(Size(size.width*0.7, 50)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),

                    onPressed: (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>  DashBoardScreen(index: 0, title: '',)),
                      // );
                    }, child: Text('Scan', style: buttonStyle)),
              ),
            ),
            SizedBox(
              height: size.height*0.3,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/wheat.png',
                  height: 100,
                  // width: 200,
                  fit: BoxFit.scaleDown,
                ),
                Image.asset(
                  'assets/images/wheat.png',
                  height: 100,
                  // width: 200,
                  fit: BoxFit.scaleDown,
                ),
                Image.asset(
                  'assets/images/wheat.png',
                  height: 100,
                  // width: 200,
                  fit: BoxFit.scaleDown,
                ),

              ],
            ),

        ],),
      ),

    );
  }
}
