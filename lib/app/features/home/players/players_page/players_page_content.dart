import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/home/add/add_page.dart';
import 'package:parowanie/app/features/home/players/cubit/players_cubit.dart';

class PlayersPageContent extends StatefulWidget {
  const PlayersPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayersPageContent> createState() => _PlayersPageContentState();
}

class _PlayersPageContentState extends State<PlayersPageContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PlayersCubit()..start(),
        child: BlocBuilder<PlayersCubit, PlayersState>(builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text('Coś poszło nie tak: ${state.errorMessage}'));
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final itemModels = state.items;

          return Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
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
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Losuj druzyny'),
                  ),
                ],
              ),
              ListView(
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
              ),
            ],
          );
        }));
  }
}
