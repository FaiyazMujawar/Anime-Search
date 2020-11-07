import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Constants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final List<CustomBottomNavigationBarItem> navItems;
  final Function onChange;

  const CustomBottomNavigationBar({
    Key key,
    this.selectedIndex = 0,
    @required this.onChange,
    @required this.navItems,
  }) : super(key: key);
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
    assert(widget.navItems.length > 1);
    assert(widget.onChange != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.8),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.navItems.map(
          (item) {
            int index = widget.navItems.indexOf(item);
            return GestureDetector(
              onTap: () {
                widget.onChange(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: widget.selectedIndex == index
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kAccentColor.withOpacity(0.25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              item.icon,
                              color: kAccentColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              item.title,
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      )
                    : Icon(
                        item.icon,
                        size: 25,
                        color: kTextColor,
                      ),
              ),
            );
          },
        ).toList(),
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
