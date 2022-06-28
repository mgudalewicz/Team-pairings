import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color customColor;

  const BoxText({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.customColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color:  customColor,
        width: width,
        height: height,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
          ),
        )),
      ),
    );
  }
}
