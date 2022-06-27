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
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamsCubit()..start(),
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          final List players = state.items;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Druzyny'),
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
                                  Checkbox(
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      value: checkBoxValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkBoxValue = newValue!;
                                        });
                                      }),
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
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
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
