import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_events.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AppBloc appBloc;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.primary,
            title: const Center(
                child: Text('Profil',
                    style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
        body: Center(
            child: ElevatedButton(
                onPressed: _signOff,
                child: Text(
                  "Déconnexion",
                ))));
  }

  _signOff() {
    appBloc.add(UserSignedOff());
  }
}
