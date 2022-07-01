import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/add/add_page.dart';
import 'package:parowanie/app/features/home/players/cubit/players_cubit.dart';
import 'package:parowanie/app/features/teams/teams_page.dart';
import 'package:parowanie/repositories/items_repository.dart';

class PlayersPageContent extends StatefulWidget {
  const PlayersPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayersPageContent> createState() => _PlayersPageContentState();
}

class _PlayersPageContentState extends State<PlayersPageContent> {
  var checkValue = false;
  int meters = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PlayersCubit(ItemsRepository())..start(),
        child: BlocBuilder<PlayersCubit, PlayersState>(builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text('Coś poszło nie tak: ${state.errorMessage}'));
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final players = state.players;
          final checkBox = state.checkBox;
          final itemModels = state.items;
          int meter = itemModels.where((a) => a.value == true).length;
          meters = meter;

          return Column(
            children: [
              const SizedBox(height: 10),
              Row(
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
                            MaterialPageRoute(builder: (context) => TeamsPage(players: players, checkBox: checkBox)),
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
              ),
              changeAllValue(itemModels, context),
              const Divider(color: Colors.blue),
              Expanded(child: showListWithChoice(itemModels, context)),
            ],
          );
        }));
  }

  ListView showListWithChoice(List<dynamic> itemModels, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (final itemModel in itemModels) ...[
          Dismissible(
              key: ValueKey(itemModel.id),
              onDismissed: (_) {
                context.read<PlayersCubit>().deleted(itemModel.id);
              },
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                  value: itemModel.value,
                  title: Text(itemModel.name),
                  onChanged: (newValue) {
                    setState(() {
                      bool value = newValue!;
                      context.read<PlayersCubit>().chamgeValue(value, itemModel.id);
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
                  context.read<PlayersCubit>().chamgeValue(value, itemModel.id),
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
