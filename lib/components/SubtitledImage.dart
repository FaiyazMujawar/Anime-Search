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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
          child: Column(
            children: [
              Image.network(
                url,
                height: height,
                width: width,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
