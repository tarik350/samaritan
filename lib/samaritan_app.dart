import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_samaritan/pages/saved.dart';
import 'package:project_samaritan/pages/home.dart';
import 'package:project_samaritan/pages/scan_page.dart';
import 'theme/styles.dart' as style;

class SamaritanApp extends StatefulWidget {
  const SamaritanApp({Key? key}) : super(key: key);

  @override
  State<SamaritanApp> createState() => _SamaritanAppState();
}

class _SamaritanAppState extends State<SamaritanApp> {
  int _currentIndex = 0;
  late PageController _pageController;

  int _selectedIndex = 0;

  ////
  static final List _widgetOptions = [Home(), CameraScan(), SavedPage()];

  @override
  void initState() {
    super.initState();
    // _pageController = PageController();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: style.Style.medicineDescriptionColorMain,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: style.Style.medicineDescriptionColorSecondary,
              tabs: const [
                GButton(
                  icon: Icons.food_bank_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: 'Order',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
    );
  }
}
