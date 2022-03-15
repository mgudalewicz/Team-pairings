import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const BoxText({
    Key? key,
    required this.text,
    this.width = 90,
    this.height = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color.fromARGB(143, 33, 149, 243),
        width: width,
        height: height,
        child: Center(child: Text(text)),
      ),
    );
  }
}
