import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parowanie/service_locator.dart';
import 'package:parowanie/models/player/player.dart';
import 'package:parowanie/models/player/player_write_request.dart';

class PlayersDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();
  final FirebaseAuth _firebaseAuth = sl();

  Future<Map<String, Player>> fetchWithUserId() async {
    User? user = _firebaseAuth.currentUser;
    final QuerySnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection('users').doc(user!.uid).collection('items').get();

    final Map<String, Player> players = <String, Player>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final Player player = Player.fromJson(doc.data()..['id'] = doc.id);
      players[doc.id] = player;
    }

    return players;
  }

  Stream<List<Player>> getItemsStream() {
    User? user = _firebaseAuth.currentUser;
    return _firebaseFirestore.collection('users').doc(user!.uid).collection('items').snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return Player.fromJson(doc.data()..['id'] = doc.id);
          },
        ).toList();
      },
    );
  }

  Future<void> create({
    required PlayerWriteRequest playerWriteRequest,
  }) {
    User? user = _firebaseAuth.currentUser;
    return _firebaseFirestore.collection('users').doc(user!.uid).collection('items').add(playerWriteRequest.toJson());
  }

  Future<void> update({
    required PlayerWriteRequest playerWriteRequest,
    required String id,
  }) {
    User? user = _firebaseAuth.currentUser;
    return _firebaseFirestore
        .collection('users')
        .doc(user!.uid)
        .collection('items')
        .doc(id)
        .update(playerWriteRequest.toJson());
  }

  Future<void> deleted({required String id}) {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return _firebaseFirestore.collection('users').doc(userId).collection('items').doc(id).delete();
  }

  Future<void> changeValue({
    required bool value,
    required String id,
  }) {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('items')
        .doc(id)
        .update({'value': value});
  }

    Future<void> endMatch({required String id, required int goalsConceded, required int goalsScored}) {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    int win = 0;
    int lost = 0;
    int draw = 0;
    int score = 0;

    if (goalsConceded < goalsScored) {
      win++;
      score += 3;
    } else if (goalsConceded > goalsScored) {
      lost++;
    } else {
      draw++;
      score += 1;
    }
    return FirebaseFirestore.instance.collection('users').doc(userId).collection('items').doc(id).update({
      'goals_conceded': FieldValue.increment(goalsConceded),
      'goals_scored': FieldValue.increment(goalsScored),
      'matches': FieldValue.increment(1),
      'wins': FieldValue.increment(win),
      'losts': FieldValue.increment(lost),
      'draws': FieldValue.increment(draw),
      'score': FieldValue.increment(score),
    });
  }
}
