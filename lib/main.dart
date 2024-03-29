import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parowanie/app/app.dart';
import 'package:parowanie/service_locator.dart';

import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDepenedencies();
  runApp(const MyApp());
}
