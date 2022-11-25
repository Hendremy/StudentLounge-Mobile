import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final String text = "Réessayer";
  final Function retry;
  const RetryButton({super.key, required this.retry});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () => retry(),
        icon: const Icon(Icons.refresh, size: 24),
        label: Text(text));
  }
}
