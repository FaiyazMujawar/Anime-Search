import 'package:anime_search/screens/SearchScreen.dart';
import 'package:anime_search/screens/TopAnimesPage.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                TrendingPage(),
                SearchScreen(),
                Container(
                  child: Center(
                    child: Text("Favorites"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Feather.bar_chart_2),
            title: Text("Top Charts"),
            activeColor: Colors.purple.shade500,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Feather.search),
            title: Text("Search"),
            activeColor: Colors.blue.shade500,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorites"),
            activeColor: Colors.red.shade500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
