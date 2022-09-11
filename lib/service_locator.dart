import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:parowanie/app/features/home/statistic_page/cubit/statistics_cubit.dart';
import 'package:parowanie/firebase/data_providers/players_data_provider.dart';
import 'package:parowanie/manager/players_data_manager.dart';

final sl = GetIt.instance;

void configureDepenedencies() {
  //Firebase
  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton(FirebaseFirestore.instance);

  //Provider
  sl.registerFactory(() => PlayersDataProvider());

  //Manager
  sl.registerFactory(() => PlayersDataManager());

  //Bloc
  sl.registerFactory(() => StatisticsCubit());
}
