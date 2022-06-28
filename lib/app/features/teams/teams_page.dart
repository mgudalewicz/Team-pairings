import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:parowanie/app/features/teams/cubit/teams_cubit.dart';
import 'package:parowanie/app/features/teams/matches.dart';
import 'package:parowanie/repositories/items_repository.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key, required this.players, required this.checkBox}) : super(key: key);

  final List players;
  final List checkBox;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

bool checked = false;

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsCubit(ItemsRepository()),
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          final List players = widget.players;
          final List checkBox = widget.checkBox;
          int _meter = players.where((players) => players['value'] == true).length;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Drużyny'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GroupedListView<dynamic, String>(
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
                                  Checkbox(
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      value:
                                          checkBox.firstWhere((element) => element.title.contains(groupByValue)).value,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _meter = 0;
                                          checkBox.firstWhere((element) => element.title.contains(groupByValue)).value =
                                              newValue!;
                                          for (final player in players) {
                                            if (player['group'] == groupByValue) {
                                              player['value'] = checkBox
                                                  .firstWhere((element) => element.title.contains(groupByValue))
                                                  .value;
                                            }
                                          }
                                        });
                                      }),
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
                    itemBuilder: (context, dynamic element) => Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          if (element['value'] == true)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                            )
                          else
                            Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
                          const SizedBox(width: 10),
                          Text(element['name']),
                        ],
                      ),
                    ),
                    itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                    floatingHeader: true, // optional
                    order: GroupedListOrder.ASC, // optional
                  ),
                ),
                if (_meter == 3 || _meter == 4)
                  SizedBox(
                    width: 1000,
                    child: ElevatedButton(
                      onPressed: () {
                        final List match = players.where((players) => players['value'] == true).toList();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Matches(players: match)),
                        );
                      },
                      child: const Text('Zagraj mecz'),
                    ),
                  )
                else
                  const SizedBox(
                    width: 1000,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text('Musisz wybrać 2 drużyny'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
