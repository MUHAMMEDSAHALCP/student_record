import 'package:flutter/material.dart';
import 'package:hive_data_base/screens/add_screen.dart';
import 'package:hive_data_base/screens/studentscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelectedIndex = 0;
  final _pages = [
    const StudentScreen(),
    const AddScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff4495BD),
        selectedItemColor: Colors.purple.shade900,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentSelectedIndex,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Student',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Add'),
        ],
      ),
    );
  }
}
