import 'package:flutter/material.dart';
//import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rive/rive.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  StateMachineController? controller;
  int starCount = 5;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Text(
                'With how many stars do!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: 'Arial',
                  fontSize: 20,
                ),
              ),
              Text(
                'do you rate your experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: 'Arial',
                  fontSize: 20,
                ),
              ),
              Text(
                'Tap a star to rate!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: 'Arial',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              //StarRating(
              //  size: 55,
              //  color: Colors.orange,
              //  borderColor: Colors.grey,
              //  allowHalfRating: true,
              //  starCount: starCount,
              //  rating: rating,
              //  onRatingChanged: (newRating) {
              //    setState(() {
              //      if (rating == newRating) {
              //        rating = 0.0;
              //      } else {
              //        rating = newRating;
              //      }
              //    });
              //  },
              //),
              Center(
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  glow: false,
                  itemCount: 5,
                  itemSize: 55, 
                  unratedColor: Colors.grey.shade300,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) =>
                          const Icon(Icons.star, color: Colors.orange),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                elevation: 2,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Rate Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
