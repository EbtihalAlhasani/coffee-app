import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.4735, 55.9754),
    zoom: 4.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(21.4735, 55.9754),
      tilt: 59.440717697143555,
      zoom: 4.151926040649414);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Map',
          style: TextStyle( fontFamily: "Poppins",color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:0, title: '',)));
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
        height: size.height,
        width: size.width,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),



    );
  }
}
