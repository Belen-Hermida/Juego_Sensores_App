import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(const JuegoPinguinoApp());

class JuegoPinguinoApp extends StatelessWidget {
  const JuegoPinguinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JuegoPage(),
    );
  }
}

class JuegoPage extends StatefulWidget {
  const JuegoPage({super.key});

  @override
  State<JuegoPage> createState() => _JuegoPageState();
}

class _JuegoPageState extends State<JuegoPage> {
  double posX = 150.0;
  double posY = 150.0;

  final double pinguinoSize = 50.0;
  final double metaSize = 60.0;

  double metaX = 200.0;
  double metaY = 500.0;

  List<Offset> obstaculos = [];
  StreamSubscription<AccelerometerEvent>? _subscription;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reiniciarNivelCompleto();
    });

    _subscription = accelerometerEventStream().listen((
      AccelerometerEvent event,
    ) {
      if (!mounted) return;
      setState(() {
        posX -= event.x * 3.0;
        posY += event.y * 3.0;
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        posX = posX.clamp(0, screenWidth - pinguinoSize);
        posY = posY.clamp(0, screenHeight - pinguinoSize - 50);

        comprobarChoque();
      });
    });
  }

  void reiniciarNivelCompleto() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      posX = screenWidth / 2 - (pinguinoSize / 2);
      posY = 50.0;

      metaX = _random.nextDouble() * (screenWidth - metaSize);
      metaY =
          (screenHeight / 2) +
          (_random.nextDouble() * (screenHeight / 2 - metaSize - 50));
      obstaculos.clear();
      for (int i = 0; i < 8; i++) {
        obstaculos.add(
          Offset(
            _random.nextDouble() * (screenWidth - 40),
            150 + _random.nextDouble() * (screenHeight - 350),
          ),
        );
      }
    });
  }

  void comprobarChoque() {
    double distanciaMeta = (Offset(posX, posY) - Offset(metaX, metaY)).distance;
    if (distanciaMeta < 40) {
      _notificar("¡Meta alcanzada! Generando nuevo nivel...");
      reiniciarNivelCompleto();
    }

    for (var punto in obstaculos) {
      double distanciaObs = (Offset(posX, posY) - punto).distance;
      if (distanciaObs < 35) {
        _notificar("¡CHOCASTE!, Intentalo de nuevo...");
        setState(() {
          posX = 150.0;
          posY = 50.0;
        });
      }
    }
  }

  void _notificar(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj), duration: const Duration(milliseconds: 800)),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2DADD),
      body: Stack(
        children: [
          // Meta
          Positioned(
            left: metaX,
            top: metaY,
            child: Container(
              width: metaSize,
              height: metaSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: const Icon(Icons.flag, color: Colors.lightBlue, size: 30),
            ),
          ),
          // Obstaculos
          ...obstaculos.map(
            (pos) => Positioned(
              left: pos.dx,
              top: pos.dy,
              child: const Icon(Icons.star, size: 40, color: Colors.red),
            ),
          ),
          // tucan
          Positioned(
            left: posX,
            top: posY,
            child: SizedBox(
              width: pinguinoSize,
              height: pinguinoSize,
              child: Image.asset('assets/tucan.png', fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}
