import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:parowanie/app/features/teams/cubit/teams_cubit.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key, required this.meters}) : super(key: key);

  final int meters;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsCubit()..start(),
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          final int teams = (state.items.length / 2).floor();
          final List itemModels = state.items;
          int z = 0;
          int i = 0;
          List players = [];
          for (i; i < teams; i++) {
            int x = i + 1;
            int y = 2 * i;
            players.add({
              'group': 'Druzyna $x',
              'name': itemModels[y].name,
              'id': itemModels[y].id,
              'value': false,
            });
            players.add({
              'group': 'Druzyna $x',
              'name': itemModels[y + 1].name,
              'id': itemModels[y + 1].id,
              'value': false,
            });
            if (widget.meters % 2 == 1 && i == teams - 1) {
              int lastTeam = teams + 1;
              int lastIndex = 2 * teams;
              players.add({
                'group': 'Druzyna $lastTeam',
                'name': itemModels[lastIndex].name,
                'id': itemModels[lastIndex].id,
                'value': false,
              });
            }
          }

          return Scaffold(
            appBar: AppBar(),
            body: GroupedListView<dynamic, String>(
              elements: players,
              groupBy: (element) => element['group'],
              groupSeparatorBuilder: (String groupByValue) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Divider(color: Colors.blue),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                groupByValue,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const Divider(color: Colors.blue),
                  ],
                ),
              ),
              itemBuilder: (context, dynamic element) => Text(element['name']),
              itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
              order: GroupedListOrder.ASC, // optional
            ),
          );
        },
      ),
    );
  }
}
