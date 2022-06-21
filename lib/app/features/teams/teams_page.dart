import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    int teams = (widget.meters / 2).ceil();

    return BlocProvider(
      create: (context) => TeamsCubit()..start(),
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          final itemModels = state.items;

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [
                          const Divider(color: Colors.blue),
                          for (final itemModel in itemModels) ...[
                            Dismissible(
                                key: ValueKey(itemModel.id),
                                onDismissed: (_) {},
                                child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: Colors.green,
                                    value: itemModel.value,
                                    title: Text(itemModel.name + teams.toString()),
                                    onChanged: (newValue) {
                                      setState(() {
                                        bool value = newValue!;
                                      });
                                    })),
                          ],
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
