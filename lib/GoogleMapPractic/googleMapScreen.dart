import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class googleMapScreens extends StatefulWidget {
  const googleMapScreens({Key? key}) : super(key: key);

  @override
  State<googleMapScreens> createState() => _googleMapScreensState();
}

class _googleMapScreensState extends State<googleMapScreens> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(12.9716, 77.5946 ),
      zoom: 14
  );

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(12.9716, 77.5946 ),
        infoWindow: InfoWindow(
            title: "Bengaluru"
        )
    ),

    Marker(
        markerId: MarkerId('2'),
        position: LatLng(12.9569, 77.7011 ),
        infoWindow: InfoWindow(
            title: "Marathali"
        )
    ),

    Marker(
        markerId: MarkerId('3'),
        position: LatLng(12.7786, 77.6441 ),
        infoWindow: InfoWindow(
            title: "APC Circle Jigni"
        )
    ),

    Marker(
        markerId: MarkerId('4'),
        position: LatLng(12.9767, 77.5713 ),
        infoWindow: InfoWindow(
            title: "Majestic"
        )
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google map'),),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_marker),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(12.9569, 77.7011 ),
                  zoom: 14
              )
          ));
          setState(() {});
        },
        child: Icon(Icons.location_on_rounded),
      ),
    );
  }



}
