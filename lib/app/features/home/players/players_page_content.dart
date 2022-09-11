import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/add/add_page.dart';
import 'package:parowanie/app/features/home/players/cubit/players_cubit.dart';
import 'package:parowanie/app/features/teams/teams_page.dart';
import 'package:parowanie/models/player/player.dart';

class PlayersPageContent extends StatefulWidget {
  const PlayersPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayersPageContent> createState() => _PlayersPageContentState();
}

class _PlayersPageContentState extends State<PlayersPageContent> {
  bool checkValue = false;
  int meters = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => PlayersCubit()..init(),
          child: BlocBuilder<PlayersCubit, PlayersState>(builder: (BuildContext context, PlayersState state) {
            if (state is PlayersErrorState) {
              return Center(child: Text('Coś poszło nie tak: ${state.error}'));
            }
            if (state is PlayersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlayersInfoState) {
              final players = state.players;
              meters = players.where((player) => player.value == true).length;
              return Column(
                children: [
                  const SizedBox(height: 10),
                  _playerView(context, players),
                  changeAllValue(players, context),
                  const Divider(color: Colors.blue),
                  Expanded(child: showListWithChoice(players, context)),
                ],
              );
            }
            return const Center(child: Text('Coś poszło nie tak'));
          })),
    );
  }

  Row _playerView(BuildContext context, List<Player> players) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('Dodaj gracza'),
          ),
        ),
        const SizedBox(width: 20),
        if (meters >= 3)
          SizedBox(
            width: 180,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TeamsPage()),
                );
              },
              child: const Text('Losuj drużyny'),
            ),
          ),
        if (meters < 3)
          const SizedBox(
            width: 180,
            child: ElevatedButton(
              onPressed: null,
              child: Text('Za mało zawodników'),
            ),
          ),
      ],
    );
  }

  ListView showListWithChoice(List<dynamic> players, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (final player in players) ...[
          Dismissible(
              key: ValueKey(player.id),
              onDismissed: (_) {
                context.read<PlayersCubit>().deleted(player.id);
              },
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                  value: player.value,
                  title: Text(player.name),
                  onChanged: (newValue) {
                    setState(() {
                      bool value = newValue!;
                      context.read<PlayersCubit>().changeValue(value, player.id);
                    });
                  })),
        ],
      ],
    );
  }

  Row changeAllValue(List<dynamic> itemModels, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: Colors.green,
          checkColor: Colors.white,
          value: checkValue,
          onChanged: (bool? value) {
            setState(() {
              for (final itemModel in itemModels) {
                [
                  checkValue = value!,
                  context.read<PlayersCubit>().changeValue(value, itemModel.id),
                ];
              }
            });
          },
        ),
        const Text('Zaznacz wszystkich'),
        const SizedBox(width: 60),
        Text('zaznaczonych: ' + meters.toString()),
      ],
    );
  }
}
