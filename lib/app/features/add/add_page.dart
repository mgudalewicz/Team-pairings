import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/app.dart';
import 'package:parowanie/app/features/add/cubit/add_cubit.dart';
import 'package:parowanie/repositories/items_repository.dart';

class AddPage extends StatelessWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddCubit(ItemsRepository()),
        child: BlocBuilder<AddCubit, AddState>(builder: (context, state) {
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
                            context.read<AddCubit>().addPlayers(controller.text);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                                fullscreenDialog: true,
                              ),
                            );
                          }
                        },
                        child: const Text('Dodaj gracza'))
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
