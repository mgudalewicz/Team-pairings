part of 'add_cubit.dart';

@immutable
class AddState {
    const AddState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<ItemsModel> items;
  final bool isLoading;
  final String errorMessage;
}

