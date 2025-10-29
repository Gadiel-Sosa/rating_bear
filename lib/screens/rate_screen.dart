import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rive/rive.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  StateMachineController? controller;
  SMINumber? numLookInput;
  SMITrigger? successInput;
  SMITrigger? failInput;
  double rating = 0.0;
  int itemCount = 5;
  double itemSize = 55;

  //numLookInput?.value = 50.0;

  //void _updateNumLook(double rating) {
  //  if (numLookInput == null) return;
  //
  //  if (rating >= 4.0) {
  //    numLookInput!.value = 2;
  //  } else if (rating >= 2.5) {
  //    numLookInput!.value = 1;
  //  } else {
  //    numLookInput!.value = 0;
  //  }
  //}

  void _rateNow() {
    if (controller == null) return;

    //_updateNumLook(rating);

    if (rating >= 3) {
      successInput?.fire();
    } else {
      failInput?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  stateMachines: const ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );

                    if (controller != null) {
                      artboard.addController(controller!);

                      numLookInput =
                          controller!.findInput<double>('numLook')
                              as SMINumber?;
                      successInput =
                          controller!.findInput<bool>('trigSuccess')
                              as SMITrigger?;
                      failInput =
                          controller!.findInput<bool>('trigFail')
                              as SMITrigger?;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enjoying Sounter?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'With how many stars do',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Arial',
                  fontSize: 20,
                ),
              ),
              
              Text(
                'you rate your experience',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Arial',
                  fontSize: 20,
                ),
              ),
              
              Text(
                'Tap a star to rate!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Arial',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                glow: false,
                itemCount: itemCount,
                itemSize: itemSize,
                unratedColor: Colors.grey.shade300,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder:
                    (context, _) =>
                        const Icon(Icons.star, color: Colors.orange),
                onRatingUpdate: (newRating) {
                  setState(() => rating = newRating);
                  //_updateNumLook(rating);
                },
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: _rateNow,
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
                child: const Text(
                  'Rate Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
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
