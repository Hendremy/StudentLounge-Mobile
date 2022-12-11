import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'dart:io';

// class SimpleBlocDelegate extends BlocObserver {
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     print(transition.toString());
//     super.onTransition(bloc, transition);
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  String downloadPath = await getDownloadPath();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBetmZJ6mgfSwWj6jlf2hOmgNNyEAu5FR8",
    appId: "1:617490373514:android:a76f2d5dea15e14de50673",
    messagingSenderId: "617490373514",
    projectId: "studentlounge-android",
  ));

  runApp(App(
    key: const Key("app"),
    apiUrl: "https://porthos-intra.cg.helmo.be/e190449",
    downloadPath: downloadPath,
  ));
  // key: Key("app"), apiUrl: "https://10.0.2.2:44321/"));
}

Future<String> getDownloadPath() async {
  String downloadPath = "";
  if (Platform.isAndroid) {
    Directory? appDocDir = await getExternalStorageDirectory();
    if (appDocDir != null) {
      downloadPath = appDocDir.path;
    }
  } else if (Platform.isIOS) {
    Directory tempDir = await getTemporaryDirectory();
    downloadPath = tempDir.path;
  }
  return downloadPath;
}
