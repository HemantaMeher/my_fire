import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({Key? key}) : super(key: key);

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
      target:LatLng(12.9569, 77.7011),
    zoom: 13.5,
  );

  final Set<Marker> _markers = {};
  Set<Polygon> _polygone = HashSet<Polygon>();
  final List<LatLng> points = [
    // LatLng(12.9569, 77.7011),
    LatLng(12.946009738793698, 77.72255149776956),
    LatLng(12.93681678829576, 77.68362836230203),
    // LatLng(12.980175546828006, 77.72297881574028),
    LatLng(12.963995523115845, 77.67419137312461),
    LatLng(12.99117129033297, 77.71332816757752),
    LatLng(12.946009738793698, 77.72255149776956),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygone.add(
      Polygon(
          polygonId: PolygonId('1'),
          points: points,
        fillColor: Color(0x4ddc1bea),
        strokeWidth: 1,
        strokeColor: Colors.pink
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polygone in Map'),),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        polygons: _polygone,
      ),
    );
  }
}
