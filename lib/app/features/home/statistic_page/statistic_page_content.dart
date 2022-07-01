import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/home/statistic_page/cubit/statistics_cubit.dart';
import 'package:parowanie/repositories/items_repository.dart';
import 'package:parowanie/widgets/box_text.dart';

class StatisticsPageContent extends StatelessWidget {
  const StatisticsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsCubit(ItemsRepository())..start(),
      child: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text('Coś poszło nie tak: ${state.errorMessage}'));
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final itemModels = state.items;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _caption(),
              ),
              const Divider(color: Colors.blue),
              _statistics(itemModels),
            ],
          );
        },
      ),
    );
  }

  Row _caption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        BoxText(text: 'Z\na\nw\no\nd\nn\ni\nk', width: 90, height: 120, customColor: Colors.blue),
        BoxText(text: 'P\nu\nn\nk\nt\ny', width: 30, height: 120, customColor: Colors.blueAccent),
        BoxText(text: 'M\ne\nc\nz\ne', width: 30, height: 120, customColor: Colors.lightBlue),
        BoxText(text: 'W\ny\ng\nr\na\nn\ne', width: 30, height: 120, customColor: Colors.lightBlueAccent),
        BoxText(text: 'P\nr\ne\ng\nr\na\nn\ne', width: 30, height: 120, customColor: Colors.blue),
        BoxText(text: 'R\ne\nm\ni\ns\ny', width: 30, height: 120, customColor: Colors.blueAccent),
        BoxText(text: 'G z\no d\nl  o\ne b\n   y\n.  t\n   e', width: 30, height: 120, customColor: Colors.lightBlue),
        BoxText(
            text: 'G s\no  t\nl   r\ne  a\n    c\n.   o\n    n\n    e',
            width: 30,
            height: 120,
            customColor: Colors.lightBlueAccent),
      ],
    );
  }

  Expanded _statistics(List<dynamic> itemModels) {
    return Expanded(
      child: ListView(
        children: [
          for (final itemModel in itemModels) ...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BoxText(text: itemModel.name, width: 90, height: 20, customColor: Colors.blue),
                  BoxText(text: itemModel.score.toString(), width: 30, height: 20, customColor: Colors.blueAccent),
                  BoxText(text: itemModel.matches.toString(), width: 30, height: 20, customColor: Colors.lightBlue),
                  BoxText(text: itemModel.wins.toString(), width: 30, height: 20, customColor: Colors.lightBlueAccent),
                  BoxText(text: itemModel.losts.toString(), width: 30, height: 20, customColor: Colors.blue),
                  BoxText(text: itemModel.draws.toString(), width: 30, height: 20, customColor: Colors.blueAccent),
                  BoxText(text: itemModel.goalsScored.toString(), width: 30, height: 20, customColor: Colors.lightBlue),
                  BoxText(
                      text: itemModel.goalsConceded.toString(),
                      width: 30,
                      height: 20,
                      customColor: Colors.lightBlueAccent),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
