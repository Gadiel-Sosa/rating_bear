import 'package:flutter/material.dart';

class TextDescription extends StatelessWidget {
  const TextDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'With how many stars do',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontFamily: 'Arial', fontSize: 20),
        ),
        Text(
          'you rate your experience',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontFamily: 'Arial', fontSize: 20),
        ),
        Text(
          'Tap a star to rate!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontFamily: 'Arial', fontSize: 20),
        ),
      ],
    );
  }
}
