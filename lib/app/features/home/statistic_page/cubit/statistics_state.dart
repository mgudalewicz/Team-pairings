part of 'statistics_cubit.dart';

@immutable
class StatisticsState {
  const StatisticsState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<ItemsModel> items;
  final bool isLoading;
  final String errorMessage;
}