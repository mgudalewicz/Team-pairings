import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayersPageContent extends StatefulWidget {
  PlayersPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayersPageContent> createState() => _PlayersPageContentState();
}

class _PlayersPageContentState extends State<PlayersPageContent> {
  bool value = false;

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
              for (final document in documents) ...[
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    value: value,
                    title: Text(document['name']),
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue!;
                      });
                    }),
              ],
            ],
          );
        });
  }
}
