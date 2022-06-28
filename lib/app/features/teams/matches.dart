import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/teams/cubit/teams_cubit.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key, required this.players}) : super(key: key);

  final List players;

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  int _firstTeamGoals = 0;
  int _secondTeamGoals = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsCubit(),
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mecz'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                firstTeamView(),
                SizedBox(
                    child: Column(
                  children: [
                    changeScoreFirstTeam(),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: const [
                          Text('. .', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                    changeScoreSecondTeam(),
                  ],
                )),
                secondTeamView(),
                endMatch(context)
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox secondTeamView() {
    return SizedBox(
        child: Column(
      children: [
        const SizedBox(height: 40),
        const Divider(color: Colors.blue),
        Text(
          widget.players[2]['group'],
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.players[2]['name'],
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        if (widget.players.length == 4)
          Text(
            widget.players[3]['name'],
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
      ],
    ));
  }

  SizedBox firstTeamView() {
    return SizedBox(
        child: Column(
      children: [
        Text(
          widget.players[0]['group'],
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.players[0]['name'],
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        Text(
          widget.players[1]['name'],
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        const Divider(color: Colors.blue),
        const SizedBox(height: 40),
      ],
    ));
  }

  SizedBox endMatch(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: ElevatedButton(
        onPressed: () {
          context.read<TeamsCubit>().endMatch(widget.players[0]['id'], _secondTeamGoals, _firstTeamGoals);
          context.read<TeamsCubit>().endMatch(widget.players[1]['id'], _secondTeamGoals, _firstTeamGoals);
          context.read<TeamsCubit>().endMatch(widget.players[2]['id'], _firstTeamGoals, _secondTeamGoals);
          if (widget.players.length == 4) {
            context.read<TeamsCubit>().endMatch(widget.players[3]['id'], _firstTeamGoals, _secondTeamGoals);
          }

          Navigator.pop(context);
        },
        child: const Text('Zakończ mecz'),
      ),
    );
  }

  Row changeScoreFirstTeam() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _firstTeamGoals++;
            });
          },
          child: const Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            primary: Colors.blue, // <-- Button color
          ),
        ),
        const SizedBox(width: 50),
        Text(
          _firstTeamGoals.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 50),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (_firstTeamGoals > 0) {
                _firstTeamGoals--;
              }
            });
          },
          child: const Icon(Icons.remove, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            primary: Colors.blue, // <-- Button color
          ),
        ),
      ],
    );
  }

  Row changeScoreSecondTeam() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _secondTeamGoals++;
            });
          },
          child: const Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            primary: Colors.blue, // <-- Button color
          ),
        ),
        const SizedBox(width: 50),
        Text(
          _secondTeamGoals.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 50),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (_secondTeamGoals > 0) {
                _secondTeamGoals--;
              }
            });
          },
          child: const Icon(Icons.remove, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            primary: Colors.blue, // <-- Button color
          ),
        ),
      ],
    );
  }
}
