import 'package:fluttertoast/fluttertoast.dart';
import 'package:parowanie/firebase/data_providers/players_data_provider.dart';
import 'package:parowanie/models/player/player_write_request.dart';
import 'package:parowanie/support_files/app_locator.dart';

class PlayersDataManager {
  final PlayersDataProvider _playersDataProvider = al();

  Future<void> getPlayers(String userId) async {
    _playersDataProvider.getItemsStream(userId);
  }

  Future<void> create(
    PlayerWriteRequest playerWriteRequest,
    String userId,
  ) async {
    try {
      await _playersDataProvider.create(
        playerWriteRequest: playerWriteRequest,
        userId: userId,
      );
      await fetch(userId);
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
        userId: userId,
      );
      await fetch(userId);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }

  Future<void> fetch(String userId) async {
    _playersDataProvider.fetchWithUserId(userId);
  }
}
