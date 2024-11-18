import 'package:flutter/material.dart';
import 'package:projeto/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Configura o controlador 
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // 3s de duração
      vsync: this,
    );

    // Add ouvinte para iniciar o timer após a animação terminar
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Espera 1s antes de navegar
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const App()),
          );
        });
      }
    });

    // Inicia a animação
    _controller.forward();
  }

  @override
  void dispose() {
    // Descarta o controlador de animação para liberar memória
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 167, 73), 
      body: Center(
        child: RotationTransition(
          turns: Tween<double>(begin: 0, end: 2).animate(_controller), // Gira duas voltas completas
          child: ScaleTransition(
            scale: _controller.drive(CurveTween(curve: Curves.easeInOut)), // Cresce suavemente
            child: Icon(
              Icons.airplane_ticket, // Ícone central
              size: 300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
