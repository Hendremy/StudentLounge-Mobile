import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_bloc.dart';
import 'package:studentlounge_mobile/blocs/app/app_events.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
        body: ListView(children: [
          Card(
              child: ListTile(
                  title: Text('Utilisateur : ${appBloc.state.fullame}'))),
          Card(
              child: ListTile(
                  title: Text('Rôles : ${appBloc.state.roles.join(',')}'))),
          Card(
            child: ListTile(
              title: const Text('Se déconnecter'),
              trailing: const Icon(Icons.logout),
              onTap: _signOff,
            ),
          )
        ]));
  }

  _signOff() {
    appBloc.add(UserSignedOff());
  }
}
