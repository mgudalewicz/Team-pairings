part of 'teams_cubit.dart';

@immutable
class TeamsState {
  const TeamsState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
    this.checkBox = const [],
  });

  final List<dynamic> items;
  final bool isLoading;
  final String errorMessage;
  final List<dynamic> checkBox;
}
