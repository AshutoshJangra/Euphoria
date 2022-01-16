import 'package:flutter/material.dart';
import '../configuration.dart';

import './home.dart';
import './upload.dart';
import './movie.dart';
import './profile_pg.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  final List<Widget> _pages = [
    Home(),
    Upload(),
    Movie(),
    Profile(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: textPrimeDark,
        unselectedItemColor: textSecondDark,
        backgroundColor: bgPrimeDark,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.home_max_rounded)),
              label: 'Home'),
          // const BottomNavigationBarItem(
          //     icon: Padding(
          //       padding: EdgeInsets.all(4.0),
          //       child: Icon(Icons.star_rounded),
          //     ),
          //     label: 'Favorite'),
          const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.add_box_rounded),
              ),
              label: 'Create'),
          // const BottomNavigationBarItem(
          //     icon: Padding(
          //       padding: EdgeInsets.all(4.0),
          //       child: Icon(Icons.notifications_active_rounded),
          //     ),
          //     label: 'Notification'),
          const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.movie_creation_rounded),
              ),
              label: 'Movies'),
          const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.supervised_user_circle_rounded),
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
