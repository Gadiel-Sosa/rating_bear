import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
                'Enjoying Sounter?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),

      ],
    );
  }
}