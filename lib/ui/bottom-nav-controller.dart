import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/const/AppColors.dart';
import 'package:project/ui/bottom_nav_pages/cart.dart';
import 'package:project/ui/bottom_nav_pages/favourite.dart';
import 'package:project/ui/bottom_nav_pages/home.dart';
import 'package:project/ui/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [
    Home(),
    Favourite(),
    Cart(),
    Profile()
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'E-Commerce',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        backgroundColor: Colors.white,
          selectedItemColor: AppColors.deep_orange,
          unselectedItemColor: Colors.grey.shade700,
          currentIndex: _currentIndex,
          selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          items: [
           BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourite'),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
           BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
          ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
