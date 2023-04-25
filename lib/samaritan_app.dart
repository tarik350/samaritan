import 'package:flutter/material.dart';
import 'package:project_samaritan/pages/saved.dart';
import 'package:project_samaritan/pages/home.dart';
import 'package:project_samaritan/pages/scan_page.dart';

class SamaritanApp extends StatefulWidget {
  const SamaritanApp({Key? key}) : super(key: key);

  @override
  State<SamaritanApp> createState() => _SamaritanAppState();
}

class _SamaritanAppState extends State<SamaritanApp> {
  List<Widget> pages = [
    Home(),
    CameraScan(),
    AnotherSaved(),
  ];
  int _selectedIndex = 0;
  void _bottomNavBarNavigator(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(55, 32, 104, 1.0),
          selectedLabelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          onTap: _bottomNavBarNavigator,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.home),
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.camera),
                ),
                label: 'scan'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.bookmark),
                ),
                label: 'saved'),
          ]),
      body: pages[_selectedIndex],
    );
  }
}
