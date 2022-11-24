import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/widgets/center_message.dart';
import 'package:studentlounge_mobile/widgets/retry_button.dart';

class RetryMessage extends StatelessWidget {
  final String text;
  final Function retry;
  const RetryMessage({super.key, required this.text, required this.retry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CenterMessage(text: text), RetryButton(retry: retry)],
    );
  }
}
