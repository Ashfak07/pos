import 'package:flutter/material.dart';
import 'package:pos/view/home_screen/home_screen.dart';
import 'package:pos/view/product_add_screen/prodcut_add_screen.dart';
import 'package:pos/view/product_screen/product_category_screen.dart';
import 'package:pos/view/profile_screen/profile_screen.dart';
import 'package:pos/view/report_screen/report_screen.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentindex = 0;
  final pages = [
    HomeScreen(),
    ProductAddScreen(),
    RepostScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentindex,
          onTap: (newstate) {
            setState(() {
              currentindex = newstate;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_open_outlined), label: 'Products'),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'Report'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_3_outlined), label: 'Profile'),
          ]),
      body: pages[currentindex],
    );
  }
}
