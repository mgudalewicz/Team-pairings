import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parowanie/support_files/app_locator.dart';
import 'package:parowanie/models/player/player.dart';
import 'package:parowanie/models/player/player_write_request.dart';

class PlayersDataProvider {
  final FirebaseFirestore _firebaseFirestore = al();

  Future<Map<String, Player>> getWithUserId(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection('users').doc(userId).collection('items').get();

    final Map<String, Player> players = <String, Player>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final Player player = Player.fromJson(doc.data()..['id'] = doc.id);
      players[doc.id] = player;
    }

    return players;
  }

  Future<void> create({
    required PlayerWriteRequest playerWriteRequest,
    required String userId,
  }) {
    return _firebaseFirestore.collection('users').doc(userId).collection('items').add(playerWriteRequest.toJson());
  }

  Future<void> update({
    required PlayerWriteRequest playerWriteRequest,
    required String userId,
    required String id,
  }) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('items')
        .doc(id)
        .update(playerWriteRequest.toJson());
  }
}
