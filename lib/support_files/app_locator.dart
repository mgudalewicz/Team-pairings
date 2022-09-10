import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:parowanie/firebase/data_providers/players_data_provider.dart';

final al = GetIt.instance;

void configureDepenedencies(){
  al.registerSingleton(FirebaseAuth.instance);
  al.registerSingleton(FirebaseFirestore.instance);

  al.registerFactory(() => PlayersDataProvider());
}