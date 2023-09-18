import 'package:flutter/material.dart';
import 'package:flutter_application/contains/contain_home.dart';
import 'package:flutter_application/contains/contain_search.dart';

class ContainMenu extends StatefulWidget {
  ContainMenu({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<ContainMenu> createState() => _ContainMenuState();
}

class _ContainMenuState extends State<ContainMenu> {
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        ContainHome(),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        ContainSearch(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 5'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 6'),
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromRGBO(255, 68, 57, 1),
        //indicatorColor: const Color.fromRGBO(46, 60, 138, 1),
        indicatorColor: const Color(0X00000000),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          // HOME
          NavigationDestination(
            selectedIcon: CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(46, 60, 138, 1),
              child: IconButton(
                icon: ImageIcon(
                  AssetImage("images/icons/home.png"),
                  color: Colors.white,
                ),
                onPressed: null,
                iconSize: 50,
              ),
            ),
            icon: ImageIcon(
              AssetImage("images/icons/home.png"),
              size: 50,
              color: Colors.white,
            ),
            label: '',
          ),
          //Person
          NavigationDestination(
            selectedIcon: CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(46, 60, 138, 1),
              child: IconButton(
                icon: ImageIcon(
                  AssetImage("images/icons/person.png"),
                  color: Colors.white,
                ),
                onPressed: null,
                iconSize: 50,
              ),
            ),
            icon: ImageIcon(
              AssetImage("images/icons/person.png"),
              color: Colors.white,
              size: 50,
            ),
            label: '',
          ),
          //Search
          NavigationDestination(
          selectedIcon: CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(46, 60, 138, 1),
            child: IconButton(
              icon: ImageIcon(
                AssetImage("images/icons/search.png"),
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 50,
            ),
          ),
          icon: ImageIcon(
              AssetImage("images/icons/search.png"),
              color: Colors.white,
              size: 50,
            ),
            label: '',
          ),
          //Logistic
          NavigationDestination(
          selectedIcon: CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(46, 60, 138, 1),
            child: IconButton(
              icon: ImageIcon(
                AssetImage("images/icons/logistic.png"),
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 50,
            ),
          ),
          icon: ImageIcon(
              AssetImage("images/icons/logistic.png"),
              color: Colors.white,
              size: 50,
            ),
            label: '',
          ),
          //Box
          NavigationDestination(
          selectedIcon: CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(46, 60, 138, 1),
            child: IconButton.outlined(
              icon: ImageIcon(
                AssetImage("images/icons/box.png"),
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 50,
            ),
          ),
          icon: ImageIcon(
              AssetImage("images/icons/box.png"),
              color: Colors.white,
              size: 50,
            ),
            label: '',
          ),
          //Scan
          NavigationDestination(
          selectedIcon: CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(46, 60, 138, 1),
            child: IconButton(
              icon: ImageIcon(
                AssetImage("images/icons/scan.png"),
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 50,
            ),
          ),
          icon: ImageIcon(
              AssetImage("images/icons/scan.png"),
              color: Colors.white,
              size: 50,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
