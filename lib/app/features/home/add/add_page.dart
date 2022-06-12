import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parowanie/app/features/home/players/players_page/players_page_content.dart';
import 'package:parowanie/app/features/home/statistic_page/statistic_page_content.dart';

class AddPage extends StatelessWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj gracza'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Zapomniałeś czegoś dodać :(';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nick',
                    hintText: 'Podaj imię zawodnika',
                  ),
                  controller: controller,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance.collection('items').add({
                        'name': controller.text,
                        'goalsCoceded': 0,
                        'goalsScored': 0,
                        'matches': 0,
                        'score': 0,
                        'value': false,
                      });
                      Navigator.popUntil(context, (route) => false);
                    }
                  },
                  child: const Text('Dodaj gracza'))
            ],
          ),
        ),
      ),
    );
  }
}
