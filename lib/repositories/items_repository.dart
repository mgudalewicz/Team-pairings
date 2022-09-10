import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parowanie/models/player/player.dart';

class ItemsRepository {
  Stream<List<Player>> getItemsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('items')
        .orderBy('name', descending: false)
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return Player(
              id: doc.id,
              name: doc['name'],
              goalsConceded: doc['goals_conceded'],
              goalsScored: doc['goals_scored'],
              matches: doc['matches'],
              score: doc['score'],
              value: doc['value'],
              draws: doc['draws'],
              losts: doc['losts'],
              wins: doc['wins'],
            );
          },
        ).toList();
      },
    );
  }

  Stream<List<Player>> getItemsStreamStatistic() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('items')
        .orderBy('score', descending: true)
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return Player(
              id: doc.id,
              name: doc['name'],
              goalsConceded: doc['goals_conceded'],
              goalsScored: doc['goals_scored'],
              matches: doc['matches'],
              score: doc['score'],
              value: doc['value'],
              draws: doc['draws'],
              losts: doc['losts'],
              wins: doc['wins'],
            );
          },
        ).toList();
      },
    );
  }

  Future<void> deleted({required String id}) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance.collection('users').doc(userId).collection('items').doc(id).delete();
  }

  Future<void> chamgeValue({required bool value, required String id}) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
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

  Future<void> addPlayers({required String text}) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance.collection('users').doc(userId).collection('items').add({
      'name': text,
      'goals_conceded': 0,
      'goals_scored': 0,
      'matches': 0,
      'score': 0,
      'value': false,
      'draws': 0,
      'losts': 0,
      'wins': 0,
    });
  }

  Future<void> endMatch({required String id, required int goalsConceded, required int goalsScored}) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
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
