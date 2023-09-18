//import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
@immutable
class ContainHome extends StatefulWidget {
  
  ContainHome({super.key});

  @override
  State<ContainHome> createState() => _ContainHomeState();
}

class _ContainHomeState extends State<ContainHome> {

  //static String facebookId = "xxxxxxxx";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(padding: const EdgeInsets.all(8), 
        children: const <Widget>[
         Text("Contain Home"),
      ]),
    );
  }
}