import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'search_anime_page.dart';
import 'top_animes_page.dart';
import '../components/cutom_navigation_bar.dart';

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
      body: SafeArea(
        child: Center(
          child: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(
                  () => _currentIndex = index,
                );
              },
              children: [
                TopAnimesPage(),
                SearchAnimePage(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onChange: (index) {
          setState(
            () {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
          );
        },
        navItems: <CustomBottomNavigationBarItem>[
          CustomBottomNavigationBarItem(
            icon: MaterialCommunityIcons.trophy_award,
            title: 'Top Animes',
          ),
          CustomBottomNavigationBarItem(
            icon: Feather.search,
            title: 'Search',
          ),
        ],
      ),
    );
  }
}
