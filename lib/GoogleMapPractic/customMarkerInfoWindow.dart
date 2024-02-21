import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  String imgUrl = 'https://s3-alpha-sig.figma.com/img/55e5/89cc/e2202896041a42ae3b8015bf5963cb69?Expires=1697414400&Signature=YyJWRuBc44C65O8-HvrnAHSSfLmIZmudYte24-Sh4dPD1iU8gnJJ4Ssd98UYm7SXxQSzl4RwEPTgvsJi~kuevnw5TasalKmYuCjCmWYlJbY666DYMK1NyfiEgwRQcvXF5UtBitOPWV0O4nQ2GVMtsbw1fvqX4WQ0pTlxZYwfx5qTqFB8hXKaT29efo~~V6O6tmaMcYpDlypkRENDMB1mReJ6nn6BmZZFmJpmySVRp3H0DyaS3QtI1wDtxjF64aLU68P5yCEGgJV7ukqotqiybKNnKyvU63zZAAIXAK8Af5wNVJEfgrb-2T~9WvwTR3~Fd17k1~quZ6HYy25vKZte8g__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4';

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> _markers = [];
  final List<LatLng> _latLong = [
    //mara
    LatLng(12.97707,77.59957),
    LatLng(12.881782729338667,77.60019652645397),
    LatLng(13.059883089238728,77.53204736861541),
    LatLng(12.994992734452618,77.65427026782791),
    LatLng(12.757154142246987,77.49601314307564),
    LatLng(12.990476908103773,77.77910135361267),
    LatLng(13.02058334337087,77.58752725877957),
    LatLng(12.99917469798921,77.77429483510431),
    LatLng(13.01456234868883,77.62323282484165),
    LatLng(13.154345358405715,77.71112344899447),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
    for(int i=0; i<_latLong.length; i++){
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLong[i],
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              Container(
                margin: EdgeInsets.all(5),
                width: 328,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(color: Colors.grey,blurRadius: 3)
                    ]
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 96,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(image: NetworkImage(imgUrl),fit: BoxFit.cover)
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Prestige Elm Park",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Color(0xff051830)),),
                        Row(
                          children: [
                            Icon(Icons.location_on,color: Color(0xff838396),size: 16,),
                            Text("Marathahalli, Bengaluru",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff838396)),)
                          ],
                        ),
                        Text("1,2,3 BR Apartments",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xff051830)),),
                        Container(
                          width: 91,
                          height: 21,
                          decoration: BoxDecoration(
                            color: Color(0xff0B458C),
                          ),
                          child: Center(child: Text("₹ 70L Onwards",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.white),)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              _latLong[i]
          );
        },
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Costom Marker Info Window'),),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(12.9569, 77.7011),
                zoom: 14,
              ),
            markers: Set.of(_markers),
            onMapCreated: (controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (argument) {
                _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },

          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 125,
            width: 328,
            offset: 35,
          )
        ],
      ),
    );
  }
}
