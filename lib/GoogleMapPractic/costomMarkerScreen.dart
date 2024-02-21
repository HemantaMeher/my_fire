import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CortomMarkerScreen extends StatefulWidget {
  const CortomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CortomMarkerScreen> createState() => _CortomMarkerScreenState();
}

class _CortomMarkerScreenState extends State<CortomMarkerScreen> {

  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? markerImages;

  List<String> images = [
    "assets/car.png",
    "assets/car1.png",
    "assets/location.png",
    "assets/location1.png",
    "assets/motorbike.png",
    "assets/bicycle.png",
  ];

  final List<Marker> _markers = [];
  final List<LatLng> _latLong = [
    //mara
    LatLng(12.9569, 77.7011),
    LatLng(12.946009738793698, 77.72255149776956),
    LatLng(12.93681678829576, 77.68362836230203),
    LatLng(12.980175546828006, 77.72297881574028),
    LatLng(12.963995523115845, 77.67419137312461),
    LatLng(12.99117129033297, 77.71332816757752),

  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(12.9569, 77.7011),
    zoom: 15
  );

  Future<Uint8List> getBytesFromAssets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async{
    for(int i = 0; i<images.length; i++){
      final Uint8List markerIcon = await getBytesFromAssets("assets/car.png", 100);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: _latLong[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(title: i.toString())
        )
      );
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Costom Marker"),),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers),
      ),

    );
  }
}
