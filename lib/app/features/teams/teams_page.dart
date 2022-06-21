import 'package:flutter/material.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key, required this.meters}) : super(key: key);

  final int meters;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    int teams = (widget.meters / 2).ceil();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              teams.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
