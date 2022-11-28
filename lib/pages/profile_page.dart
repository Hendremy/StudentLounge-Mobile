// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:studentlounge_mobile/models/app_user.dart';
// import 'package:studentlounge_mobile/theme.dart' as theme;

// class ProfilePage extends StatefulWidget {
//   final AppUser user;
//   const ProfilePage({super.key, required this.user});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             backgroundColor: theme.primary,
//             title: const Center(
//                 child: Text('Profil',
//                     style: TextStyle(fontSize: 30, fontFamily: 'Gugi')))),
//         body: Center(
//             child: ElevatedButton(
//                 onPressed: _signOff,
//                 child: const Text(
//                   "Déconnexion",
//                 ))));
//   }
// }