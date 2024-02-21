import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLongToAddress> createState() => _ConvertLatLongToAddressState();
}

class _ConvertLatLongToAddressState extends State<ConvertLatLongToAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giocoding'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () async {
                   // var address = await placemarkFromCoordinates(12.9569, 77.7011);
                   var address = await placemarkFromCoordinates(21.3305991, 83.9016266);
                   var first = address.first;
                   print(first.toString());
                   List<Location> locations = await locationFromAddress("kardola, Odisha");
                   print(locations.first.latitude);
                   print(locations.first.longitude);
                  },
                  child: Text("Convert")
              ),
            )

          ],
        ),
      ),
    );
  }
}
