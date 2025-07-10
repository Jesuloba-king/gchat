import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'chats/chats.dart';
import 'profile/person_pg.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(0xffF6F6F6),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 15,
          unselectedFontSize: 14,
          selectedLabelStyle:
              TextStyle(color: AppColors.myColor, fontFamily: "Roboto"),
          unselectedLabelStyle:
              TextStyle(color: Color(0xff666666), fontFamily: "Roboto"),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.myColor,
          unselectedItemColor: Color(0xff666666),
          unselectedIconTheme:
              IconThemeData(color: Color(0xff666666), size: 30),
          selectedIconTheme: IconThemeData(size: 30, color: AppColors.myColor),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
