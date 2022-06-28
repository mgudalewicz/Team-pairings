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

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    BoxText(
                      text: 'Zawodnik',
                    ),
                    BoxText(text: 'Punkty'),
                    BoxText(text: 'Gole zdobyte'),
                    BoxText(text: 'Gole Stracone'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              for (final itemModel in itemModels) ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BoxText(text: itemModel.name),
                      BoxText(text: itemModel.score.toString()),
                      BoxText(text: itemModel.goalsScored.toString()),
                      BoxText(text: itemModel.goalsConceded.toString()),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
