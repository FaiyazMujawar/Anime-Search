import 'package:flutter/material.dart';

class ScoreTile extends StatelessWidget {
  const ScoreTile({
    Key key,
    this.score,
    this.text,
  }) : super(key: key);

  final String score;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              score,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.star,
              size: 15,
              color: Colors.yellow.shade800,
            )
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Text(
          text,
        )
      ],
    );
  }
}
