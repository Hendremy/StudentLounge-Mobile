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
