import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/theme.dart' as theme;

class TutoratAcceptedButton extends StatelessWidget {
  const TutoratAcceptedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (() {
        SnackBar snackBar = const SnackBar(
            backgroundColor: theme.success,
            content: Text(
              'Tutorat accepté, vous pouvez désormais discuter avec votre tuteur dans l\'onglet de chat !',
              style: TextStyle(color: theme.white),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }),
      icon: const Icon(Icons.how_to_reg),
    );
  }
}
