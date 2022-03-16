import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit() : super(PlayersState());
}
