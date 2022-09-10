import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final al = GetIt.instance;

void configureDepenedencies(){
  al.registerSingleton(FirebaseAuth.instance);
  al.registerSingleton(FirebaseFirestore.instance);
}