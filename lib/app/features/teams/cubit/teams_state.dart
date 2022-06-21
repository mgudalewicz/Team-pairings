part of 'teams_cubit.dart';

@immutable
class TeamsState {
  const TeamsState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<ItemsModel> items;
  final bool isLoading;
  final String errorMessage;
}
