import 'package:flutter/material.dart';
import 'package:flutter_health_menu/screens/advisor/advisor_screen.dart';
import 'package:flutter_health_menu/screens/home/home_screen.dart';
import 'package:flutter_health_menu/screens/profile/profile_screen.dart';
import 'package:flutter_health_menu/screens/update_profile_screen/update_profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    const HomeScreen(),
    // WeeklyMenuScreen(),
    const AdvisorScreen(),
    const ProfileScreen(),
    const UpdateProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.menu_book),
          //   label: 'Weekly Menu',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: 'Advisor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
