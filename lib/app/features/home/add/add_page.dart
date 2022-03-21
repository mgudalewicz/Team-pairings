import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj gracza'),
      ),
    );
  }
}
