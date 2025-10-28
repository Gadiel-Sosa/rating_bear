import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:rive/rive.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  StateMachineController? controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int starCount = 6;
    double rating = 0.0;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: 200,
              child: RiveAnimation.asset(
                'assets/animated_login_character.riv',
                stateMachines: ["Login Machine"],
                onInit: (artboard) {
                  // Configuramos la conexión entre Flutter y la animación de Rive
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "Login Machine",
                  );
                },
              ),
            ),
            StarRating(
              size: 40.0,
              color: Colors.orange,
              borderColor: Colors.grey,
              allowHalfRating: true,
              starCount: starCount,
              rating: rating,
              onRatingChanged: (rating) => setState(() {rating = rating;}),


            ),
          ],
        ),
      ),
    );
  }
}
