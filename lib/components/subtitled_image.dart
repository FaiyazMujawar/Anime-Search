import 'package:flutter/material.dart';

import '../Constants.dart';

class SubtitledImage extends StatelessWidget {
  const SubtitledImage({
    Key key,
    @required this.url,
    @required this.subtitle,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final String url;
  final String subtitle;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                url,
                height: height,
                width: width,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: kBodyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
