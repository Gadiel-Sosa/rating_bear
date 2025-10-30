import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_bear/utils/no_thanks_button.dart';
import 'package:rating_bear/utils/rate_now_button.dart';
import 'package:rating_bear/utils/text_description.dart';
import 'package:rating_bear/utils/text_title.dart';
import 'package:rive/rive.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});
  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  // Contiene el dibujo o animación principal cargada desde el archivo .riv
  Artboard? _artboard;
  // Controlador para manejar los estados de animación en Rive
  StateMachineController? controller;
  // Variable de entrada tipo número (por ejemplo, dirección de mirada del personaje)
  SMINumber? numLookInput;
  // Disparador de animación de éxito (cuando la calificación es alta)
  SMITrigger? successInput;
  // Disparador de animación de fallo (cuando la calificación es baja)
  SMITrigger? failInput;
  double rating = 0.0; // Valor actual de la calificación seleccionada
  int itemCount = 5; // Número de estrellas
  double itemSize = 55; // Tamaño de cada estrella
  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla
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
                  'assets/animated_login_character.riv', // Archivo de animación Rive
                  stateMachines: const [
                    "Login Machine",
                  ], // Nombre del State Machine dentro del archivo .riv
                  onInit: (artboard) {
                    // Este callback se ejecuta cuando la animación está lista
                    _artboard = artboard;
                    // Se crea el controlador de la máquina de estados llamada "Login Machine"
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    // Si el controlador se inicializa correctamente
                    if (controller != null) {
                      // Se agrega el controlador al artboard para habilitar el control de animaciones
                      artboard.addController(controller!);
                      // Se buscan las entradas del State Machine (inputs definidos en Rive)
                      // Estas permiten controlar la animación desde Flutter
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
              // Texto principal de la pantalla
              const TextTitle(),
              const SizedBox(height: 20),
              // Textos secundarios de guía para el usuario
              TextDescription(),
              const SizedBox(height: 20),
              // Barra de estrellas para calificar
              RatingBar.builder(
                initialRating: rating, // Valor inicial
                minRating: 0, // Mínimo posible
                direction: Axis.horizontal,
                allowHalfRating: true, // Permite medias estrellas
                glow: false,
                itemCount: itemCount,
                itemSize: itemSize,
                unratedColor: Colors.grey.shade300,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder:
                    (context, _) =>
                        const Icon(Icons.star, color: Colors.orange),
                // Evento que se ejecuta al cambiar la calificación
                onRatingUpdate: (newRating) {
                  // Actualiza el estado con la nueva calificación
                  setState(() => rating = newRating);
                  // Si no hay una animación cargada, no hacer nada
                  if (_artboard == null) return;
                  // Reinicia el controlador actual para evitar que la animación se quede trabada
                  if (controller != null) {
                    _artboard!.removeController(controller!);
                    controller!.dispose();
                  }
                  // Crea un nuevo controlador para la máquina de estados
                  controller = StateMachineController.fromArtboard(
                    _artboard!,
                    "Login Machine",
                  );
                  // Si el nuevo controlador se inicializó correctamente, vuelve a conectar las entradas
                  if (controller != null) {
                    _artboard!.addController(controller!);
                    numLookInput =
                        controller!.findInput<double>('numLook') as SMINumber?;
                    successInput =
                        controller!.findInput<bool>('trigSuccess')
                            as SMITrigger?;
                    failInput =
                        controller!.findInput<bool>('trigFail') as SMITrigger?;
                  }
                  // Espera un instante y luego dispara la animación correspondiente
                  Future.delayed(const Duration(milliseconds: 1), () {
                    // Si la calificación es alta (3 estrellas o más)
                    if (rating == 4 || rating == 5) {
                      successInput?.fire(); // Activa animación de éxito
                      numLookInput?.value = 0;
                    } else if (rating == 3) {
                      numLookInput?.value = 50.0;
                    } else if (rating == 1 || rating == 2) {
                      failInput?.fire(); // Activa animación de fallo
                      numLookInput?.value = 100;
                    } else {
                      numLookInput?.value = 0;
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              // Botón "Rate Now" (no ejecuta lógica actualmente)
              const RateButton(),
              const SizedBox(height: 20),
              // Botón de NO Thanks
              const NoThanksButton(),
            ],
          ),
        ),
      ),
    );
  }
}
