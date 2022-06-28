import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parowanie/app/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemsModel>> getItemsStream() {
    return FirebaseFirestore.instance.collection('items').orderBy('name', descending: false).snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return ItemsModel(
              id: doc.id,
              name: doc['name'],
              goalsConceded: doc['goalsConceded'],
              goalsScored: doc['goalsScored'],
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
    return FirebaseFirestore.instance.collection('items').doc(id).delete();
  }

  Future<void> chamgeValue({required bool value, required String id}) {
    return FirebaseFirestore.instance.collection('items').doc(id).update({'value': value});
  }

  Future<void> addPlayers({required String text}) {
    return FirebaseFirestore.instance.collection('items').add({
      'name': text,
      'goalsConceded': 0,
      'goalsScored': 0,
      'matches': 0,
      'score': 0,
      'value': false,
      'draws': 0,
      'losts': 0,
      'wins': 0,
    });
  }

  Future<void> endMatch({required String id, required int goalsConceded, required int goalsScored}) {
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
    return FirebaseFirestore.instance.collection('items').doc(id).update({
      'goalsConceded': FieldValue.increment(goalsConceded),
      'goalsScored': FieldValue.increment(goalsScored),
      'matches': FieldValue.increment(1),
      'wins': FieldValue.increment(win),
      'losts': FieldValue.increment(lost),
      'draws': FieldValue.increment(draw),
      'score': FieldValue.increment(score),
    });
  }
}
