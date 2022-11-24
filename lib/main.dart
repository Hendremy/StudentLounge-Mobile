import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

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
  runApp(const App(
      key: Key("app"), apiUrl: "https://porthos-intra.cg.helmo.be/e190449"));
  // key: Key("app"), apiUrl: "https://10.0.2.2:44321/"));
}
