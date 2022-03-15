import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parowanie/widgets/box_text.dart';

class StatisticsPageContent extends StatelessWidget {
  const StatisticsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Players').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          final documents = snapshot.data!.docs;

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    BoxText(text: 'Zawodnik',),
                    BoxText(text: 'Punkty'),
                    BoxText(text: 'Gole zdobyte'),
                    BoxText(text: 'Gole Stracone'),
                  ],
                ),
              ),
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BoxText(text: document['name']),
                      BoxText(text: document['score'].toString()),
                      BoxText(text: document['goalsScored'].toString()),
                      BoxText(text: document['goalsConceded'].toString()),
                    ],
                  ),
                ),
              ],
            ],
          );
        });
  }
}
