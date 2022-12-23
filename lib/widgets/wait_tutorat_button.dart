import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class WaitTutoratButton extends StatelessWidget {
  const WaitTutoratButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (() {
        SnackBar snackBar = const SnackBar(
            backgroundColor: theme.warning,
            content: Text(
              'Demande de tutorat effectuée, patientez',
              style: TextStyle(color: theme.white),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }),
      icon: const Icon(Icons.hourglass_bottom),
    );
  }
}
