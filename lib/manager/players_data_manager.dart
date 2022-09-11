import 'package:fluttertoast/fluttertoast.dart';
import 'package:parowanie/firebase/data_providers/players_data_provider.dart';
import 'package:parowanie/models/player/player.dart';
import 'package:parowanie/models/player/player_write_request.dart';
import 'package:parowanie/service_locator.dart';

class PlayersDataManager {
  final PlayersDataProvider _playersDataProvider = sl();

  Stream<List<Player>> getPlayers() {
    return _playersDataProvider.getItemsStream();
  }

  Future<void> create(
    PlayerWriteRequest playerWriteRequest,
  ) async {
    try {
      await _playersDataProvider.create(
        playerWriteRequest: playerWriteRequest,
      );
      await fetch();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }

  Future<void> update(
    String id,
    PlayerWriteRequest playerWriteRequest,
    String userId,
  ) async {
    try {
      await _playersDataProvider.update(
        id: id,
        playerWriteRequest: playerWriteRequest,
      );
      await fetch();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }

  Future<void> fetch() async {
    _playersDataProvider.fetchWithUserId();
  }
}
