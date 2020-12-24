import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

/// @author  Harry 
/// @date  2020/11/25 19:45
class TabNavigation extends StatefulWidget {

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {

  int _currentIndex = 0;

  PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _currentIndex = page;
            });
          },
          children: [
            HomePage(),
            SearchPage(hideLeft: true),
            TravelPage(),
            MyPage(pageController: _pageController)
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _generateItem(Icons.home, '首页'),
          _generateItem(Icons.search, '搜索'),
          _generateItem(Icons.camera_alt, '旅拍'),
          _generateItem(Icons.account_circle, '我的'),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _generateItem(IconData iconData, String label) {

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  return BottomNavigationBarItem(
      icon: Icon(iconData, color: _defaultColor),
      label: label,
      activeIcon: Icon(iconData, color: _activeColor)
  );
}