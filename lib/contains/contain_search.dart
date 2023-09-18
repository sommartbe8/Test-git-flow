import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:social_share/social_share.dart';

class ContainSearch extends StatefulWidget {
  const ContainSearch({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<ContainSearch> createState() => _ContainSearchState();
}

class _ContainSearchState extends State<ContainSearch> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(13.75939304698631, 100.56811404712226);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  String facebookId = "xxxxxxxx";

  String location = "https://maps.app.goo.gl/6ee8C4jFT3SCquxL9";
  var imageBackground = "image-background.jpg";
  var videoBackground = "video-background.mp4";
  String imageBackgroundPath = "";
  String videoBackgroundPath = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ListView(padding: const EdgeInsets.all(8), 
        children: <Widget>[
        
        Card(
          color: Colors.green,
          child: SizedBox(
          height: 147,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 25.0,
              ),
              markers: {
                const Marker(
                  markerId: MarkerId('Berly8 Plus'),
                  position: LatLng(13.75939304698631, 100.56811404712226),
                  infoWindow: InfoWindow(
                    title: "Berly8 Plus",
                    snippet: "Test Marker",
                  ),
                ),
              },
            ),
          ),
        ),
      
        
        ),
          
       
      ]),
    );
  }
}



   // Row(
            //   children: [
            //     const Expanded(
            //       child: Text(
            //         "Share Test",
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ),
            //     const SizedBox(width: 40),
            //     ElevatedButton(
            //       child: const Icon(Icons.share),
            //       onPressed: () async {
            //         SocialShare.shareOptions(location).then((data) {
            //           print(data);
            //         });
            //       },
            //     ),
            //   ],
            // ),