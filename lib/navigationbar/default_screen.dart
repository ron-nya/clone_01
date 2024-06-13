import 'dart:convert';

import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/article_model.dart';
import 'package:authentication/navigationbar/article_screen.dart';
import 'package:authentication/navigationbar/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefaultScreen> {
  int _selectedIndex = 0;

  final _screens = [
    const HomeScreen(),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Write'),
    ),
    const Center(
      child: Text('Favorite'),
    ),
    const Center(
      child: Text('MyInfo'),
    ),
  ];

  void _onTapBottomNavigationBar(int index) {
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
      appBar: AppBar(
        title: const FaIcon(
          FontAwesomeIcons.at,
          color: Colors.black,
          size: Sizes.size36,
        ),
      ),
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTapBottomNavigationBar,
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
          ),
          BottomNavigationBarItem(
            label: "Write",
            icon: FaIcon(
              FontAwesomeIcons.penToSquare,
            ),
          ),
          BottomNavigationBarItem(
            label: "Favorite",
            icon: FaIcon(
              FontAwesomeIcons.heart,
            ),
          ),
          BottomNavigationBarItem(
            label: "MyInfo",
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
            ),
          ),
        ],
      ),
    );
  }
}
