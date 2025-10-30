import 'package:flutter/material.dart';

class NoThanksButton extends StatefulWidget {
  const NoThanksButton({super.key});

  @override
  State<NoThanksButton> createState() => _NoThanksButtonState();
}

class _NoThanksButtonState extends State<NoThanksButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'NO THANKS',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
