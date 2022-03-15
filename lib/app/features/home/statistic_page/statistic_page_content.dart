import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                  children: [
                    Container(width: 90, child: Text('statystyka')),
                    Text('Punkty'),
                    Text('Gole zdobyte'),
                    Text('Gole Stracone'),
                  ],
                ),
              ),
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(document['name']),
                      Text(document['score'].toString()),
                      Text(document['goalsScored'].toString()),
                      Text(document['goalsConceded'].toString()),
                    ],
                  ),
                ),
              ],
            ],
          );
        });
  }
}
