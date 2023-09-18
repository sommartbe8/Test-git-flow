import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/menubar/contain_menu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:social_share/social_share.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
//import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';

// MultiLanguageJson
import 'package:multi_language_json/multi_language_json.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBgService();
  runApp(const MyApp());
}

Future<void> initBgService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      // onBackground: onIosBackground,
    ),
  );
  service.startService();
}

onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1000), (timer) async {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "test background service",
        content: "Time ${DateTime.now()}",
      );
    }
    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(13.75939304698631, 100.56811404712226);

  final language = MultiLanguageBloc(
      initialLanguage: 'th_TH',
      defaultLanguage: 'th_TH',
      commonRoute: 'common',
      supportedLanguages: ['en_US', 'th_TH']);

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
  void initState() {
    super.initState();
    copyBundleAssets();
  }

  Future<void> copyBundleAssets() async {
    //imageBackgroundPath = await copyImage(imageBackground);
    //videoBackgroundPath = await copyImage(videoBackground);
  }

  Future<String> copyImage(String filename) async {
    final tempDir = await getTemporaryDirectory();
    ByteData bytes = await rootBundle.load("assets/$filename");
    final assetPath = '${tempDir.path}/$filename';
    File file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }

  Future<String?> pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    var path = file?.path;
    if (path == null) {
      return null;
    }
    return file?.path;
  }

  @override
  Widget build(BuildContext context) {
    return MultiLanguageStart(
        future: language.init(),
        builder: (c) => MultiStreamLanguage(
            screenRoute:const ['home'],
            builder: (c, d) => MaterialApp(
                    home: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: AppBar(
                        centerTitle: true,
                        title:Text(
                              d.getValue(route: ['title']),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ), 
                            ),
                        elevation: 0,
                        backgroundColor: Colors.white,
                      ),
                  ),
                  body: ContainMenu(),
                  // body: Container(
                  //     //color: Colors.green,
                  //     alignment: Alignment.topCenter,
                  //     padding: const EdgeInsets.all(15),
                  //     child: Column(children: [
                  //       Row(children: [
                  //         Expanded(
                  //             child: Text(d.getValue(route: ['dialog']))
                  //             ),
                  //       ]),
                  //       Row(children: [
                  //         Expanded(
                  //             child: Center(
                  //             child: TextButton(
                  //               child: const Text("EN"),
                  //               onPressed: () =>
                  //                   language.changeLanguage("en_US")),
                  //         )),
                  //       ]),
                  //        Row(children: [
                  //         Expanded(
                  //             child: Center(
                  //             child: TextButton(
                  //               child: const Text("TH"),
                  //               onPressed: () =>
                  //                   language.changeLanguage("th_TH")),
                  //         )),
                  //       ]),
                  //       // Row(children: [
                  //       //   Expanded(
                  //       //       child: Center(
                  //       //       //child: _widgetOptions.elementAt(_selectedIndex)
                  //       //       child:Text("TEST"),
                  //       //       )
                  //       //   ),
                  //       // ]),
                  //     ])
                  //   ),
                  
                  
                  //bottomNavigationBar: MenuButtomBar(),
                  
                  // BottomNavigationBar(
                  //   //type: BottomNavigationBarType.fixed,
                  //   items: const <BottomNavigationBarItem>[  
                  //         // Home
                  //         BottomNavigationBarItem(
                  //           activeIcon:  CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Color.fromRGBO(46, 60, 138, 1) ,
                  //             child: IconButton(
                  //                icon: ImageIcon(
                  //                 AssetImage("images/icons/home.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //                 onPressed: null,
                  //               ),
                  //           ),
                  //           icon: ImageIcon(
                  //                       AssetImage("images/icons/home.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //           label: '',
                  //           backgroundColor: Color.fromRGBO(255, 68, 57, 1) ,
                  //         ),
                  //         // Person
                  //         BottomNavigationBarItem(
                  //           activeIcon:  CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Color.fromRGBO(46, 60, 138, 1) ,
                  //             child: IconButton(
                  //                icon: ImageIcon(
                  //                 AssetImage("images/icons/person.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //                 onPressed: null,
                  //               ),
                  //           ),
                  //           icon: ImageIcon(
                  //                 AssetImage("images/icons/person.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //           label: '',
                  //           backgroundColor: Color.fromRGBO(255, 68, 57, 1),
                  //         ),
                  //         // Search
                  //         BottomNavigationBarItem(
                  //           activeIcon:  CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Color.fromRGBO(46, 60, 138, 1) ,
                  //             child: IconButton(
                  //               icon: ImageIcon(
                  //                 AssetImage("images/icons/search.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //                 onPressed: null,
                  //                iconSize: 50,
                  //               ),
                  //           ),
                  //           icon: IconButton(
                  //             icon: ImageIcon(
                  //                 AssetImage("images/icons/search.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //             onPressed: null,
                  //           ),
                  //          label: '',
                  //          backgroundColor: Color.fromRGBO(255, 68, 57, 1) ,
                  //         ),
                  //         // Logistic
                  //         BottomNavigationBarItem(
                  //           activeIcon:  CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Color.fromRGBO(46, 60, 138, 1) ,
                  //             child: IconButton(
                  //                icon: ImageIcon(
                  //                 AssetImage("images/icons/logistic.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //                 onPressed: null,
                  //                iconSize: 50,
                  //               ),
                  //           ),
                  //           icon: IconButton(
                  //             icon: ImageIcon(
                  //                 AssetImage("images/icons/logistic.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //             onPressed: null,
                  //           ),
                  //          label: '',
                  //          backgroundColor: Color.fromRGBO(255, 68, 57, 1) ,
                  //         ),
                  //         // Box
                  //         BottomNavigationBarItem(
                  //           activeIcon:  CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Color.fromRGBO(46, 60, 138, 1) ,
                  //             child: IconButton(
                  //                icon: ImageIcon(
                  //                 AssetImage("images/icons/box.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //                 onPressed: null,
                  //                iconSize: 50,
                  //               ),
                  //           ),
                  //           icon: IconButton(
                  //             icon: ImageIcon(
                  //                 AssetImage("images/icons/box.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //             onPressed: null,
                  //           ),
                  //          label: '',
                  //          backgroundColor: Color.fromRGBO(255, 68, 57, 1) ,
                  //         ),
                  //         // Scan
                  //         BottomNavigationBarItem(
                  //           activeIcon:  CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Color.fromRGBO(46, 60, 138, 1) ,
                  //             child: IconButton(
                  //                icon: ImageIcon(
                  //                 AssetImage("images/icons/scan.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //                 onPressed: null,
                  //                iconSize: 50,
                  //               ),
                  //           ),
                  //           icon:  ImageIcon(
                  //                 AssetImage("images/icons/scan.png"),
                  //                       color: Colors.white,
                  //                 ),
                  //          label: '',
                  //          backgroundColor: Color.fromRGBO(255, 68, 57, 1) ,
                  //         ),
                        
                  //       ],
                  //       currentIndex: _selectedIndex,
                  //       iconSize: 50,
                  //       selectedItemColor: const Color.fromRGBO( 46, 60, 138, 1)  ,
                  //       unselectedItemColor:const Color.fromRGBO(255, 255, 255, 1)  ,
                  //       onTap: _onItemTapped,
                  //       backgroundColor: const Color.fromRGBO(255, 68, 57, 1),
                  // )
                )
              )
            )
          );
  }
  // return MaterialApp(
  //   home: Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Google Maps Test'),
  //       backgroundColor: Colors.green[700],
  //     ),
  //     body: Container(
  //       color: Colors.green,
  //       alignment: Alignment.topCenter,
  //       padding: const EdgeInsets.all(15),
  //       child: Column(children: [
  //         Row(children: [
  //           Expanded(
  //               child: Container(
  //                   height: 250,
  //                   color: Colors.red,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: GoogleMap(
  //                       onMapCreated: _onMapCreated,
  //                       initialCameraPosition: CameraPosition(
  //                         target: _center,
  //                         zoom: 25.0,
  //                       ),
  //                       markers: {
  //                         const Marker(
  //                           markerId: MarkerId('Berly8 Plus'),
  //                           position:
  //                               LatLng(13.75939304698631, 100.56811404712226),
  //                           infoWindow: InfoWindow(
  //                             title: "Berly8 Plus",
  //                             snippet: "Test Marker",
  //                           ),
  //                         ),
  //                       },
  //                     ),
  //                   ))),
  //         ]),
  //         Row(
  //           children: [
  //             const Expanded(
  //               child: Text(
  //                 "Share Test",
  //                 style: TextStyle(fontSize: 16),
  //               ),
  //             ),
  //             const SizedBox(width: 40),
  //             ElevatedButton(
  //               child: const Icon(Icons.share),
  //               onPressed: () async {
  //                 SocialShare.shareOptions(location).then((data) {
  //                   print(data);
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ]),
  //     ),
  //   ),
  // );
  //}
}
