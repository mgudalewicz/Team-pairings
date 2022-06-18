import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/home/add/add_page.dart';
import 'package:parowanie/app/features/home/players/cubit/players_cubit.dart';
import 'package:parowanie/app/models/item_model.dart';

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
              ListView(
                shrinkWrap: true,
                children: [
                  for (final itemModel in itemModels) ...[
                    Dismissible(key: ValueKey(itemModel), child: PlayersBox(itemModel)),
                  ],
                ],
              ),
            ],
          );
        }));
  }

  CheckboxListTile PlayersBox(ItemsModel itemModel) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.green,
        value: itemModel.value,
        title: Text(itemModel.name),
        onChanged: (newValue) {
          setState(() {
            FirebaseFirestore.instance.collection('Players').snapshots(includeMetadataChanges: true);
          });
        });
  }
}
