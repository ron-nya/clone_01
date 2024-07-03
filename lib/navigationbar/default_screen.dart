import 'package:authentication/Activity/activity_screen.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/modalBottomSheet/write_screen.dart';
import 'package:authentication/navigationbar/home_screen.dart';
import 'package:authentication/profile/profile_screen.dart';
import 'package:authentication/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultScreen extends StatefulWidget {
  static String routerUrl = "/home";
  final String tab;
  const DefaultScreen({
    super.key,
    required this.tab,
  });

  @override
  State<DefaultScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefaultScreen> {
  int _selectedIndex = 0;

  final _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const Center(
      child: Text('Write'),
    ),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  void _onTapBottomNavigationBar(int index) {
    setState(() {
      if (index != 2) {
        _selectedIndex = index;
      } else if (index == 2) {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.5 +
                MediaQuery.of(context).viewInsets.bottom,
            child: const WriteScreen(),
          ),
        );
      }
    });
  }

  int _checkParams() {
    var index = 0;
    switch (widget.tab) {
      case 'home':
        index = 0;
        break;
      case 'search':
        index = 1;
        break;
      case 'activity':
        index = 3;
        break;
      case 'profile':
        index = 4;
        break;
      default:
        index = 0;
    }
    return index;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = _checkParams();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectedIndex == 0)
          ? AppBar(
              title: const FaIcon(
                FontAwesomeIcons.at,
                color: Colors.black,
                size: Sizes.size36,
              ),
            )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
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
