import 'package:flutter/material.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key, required List players}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  int _firstTeamGoals = 0;
  int _secondTeamGoals = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
