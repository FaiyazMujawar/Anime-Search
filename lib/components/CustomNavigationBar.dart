import 'package:anime_search/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Constants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final double height;
  final MainAxisAlignment alignment;
  final List<CustomBottomNavigationBarItem> navItems;
  final int selectedIndex;
  final Function onChange;

  const CustomBottomNavigationBar({
    Key key,
    this.height,
    this.alignment,
    @required this.navItems,
    @required this.selectedIndex,
    this.onChange,
  }) : super(key: key);
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  double _height;
  int _selectedIndex;
  MainAxisAlignment _alignment;
  List<CustomBottomNavigationBarItem> _navItems;
  Function _action;
  @override
  void initState() {
    super.initState();
    _height = 65 ?? widget.height;
    _alignment = widget.alignment;
    _navItems = widget.navItems;
    _selectedIndex = widget.selectedIndex ?? 0;
    _action = widget.onChange;
    assert(_navItems.length > 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: kSecondaryColor.withOpacity(0.6), boxShadow: [
        const BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
        ),
      ]),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      height: _height,
      child: Row(
        mainAxisAlignment: _alignment ?? MainAxisAlignment.spaceEvenly,
        children: _navItems.map((item) {
          int currentIndex = _navItems.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = currentIndex;
                _action(currentIndex);
              });
            },
            child: Container(
              child: currentIndex == _selectedIndex
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kAccentColor.withOpacity(0.25),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: kAccentColor,
                            size: 32,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAccentColor,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: 50,
                      child: Center(
                        child: Icon(
                          item.icon,
                          size: 26,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CustomBottomNavigationBarItem({Key key, this.icon, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
