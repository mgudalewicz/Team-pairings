import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:parowanie/app/features/teams/cubit/teams_cubit.dart';
import 'package:parowanie/widgets/checkbox_state.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key, required this.meters}) : super(key: key);

  final int meters;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

bool checked = false;

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsCubit()..start(),
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          final List players = state.items;
          final List checkBox = state.checkBox;

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
              ],
            ),
          );
        },
      ),
    );
  }
}
