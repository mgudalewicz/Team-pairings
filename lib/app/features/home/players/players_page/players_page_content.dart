import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child:
            BlocBuilder<PlayersCubit, PlayersState>(builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
                child: Text('Coś poszło nie tak: ${state.errorMessage}'));
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = state.documents;

          return ListView(
            children: [
              for (final document in documents) ...[
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    value: document['value'],
                    title: Text(document['name']),
                    onChanged: (newValue) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection('Players')
                            .snapshots(includeMetadataChanges: true);
                      });
                    }),
              ],
            ],
          );
        }));
  }
}
