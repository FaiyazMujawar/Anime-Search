import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final Function action;

  const NoInternetWidget({Key key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Internet!',
            style: TextStyle(
              color: Colors.yellow.shade800,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            'assets/no_connection.png',
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: Colors.yellow.shade800,
              ),
            ),
            onPressed: () {},
            child: Text(
              'TRY AGAIN',
              style: TextStyle(
                color: Colors.yellow.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
