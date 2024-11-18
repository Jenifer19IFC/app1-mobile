import 'package:flutter/material.dart';
import 'package:projeto/SplashScreen.dart';
import 'ConversorTemperatura.dart'; 
import 'ConversorMoedas.dart';
import 'Inicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // 1° tela ser exibida
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _paginaAtual = 0;
  // 3 páginas na parte inferior
  List<Widget> _paginas = [
    Inicio(),
    ConversorMoedas(), 
    ConversorTemperatura(),
  ];

  // Detalhamento das 3 páginas na parte inferior
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _paginas[_paginaAtual]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Color.fromARGB(255,42,167,73),), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on, color: const Color.fromARGB(255,42,167,73),), label: 'Moeda'),
          BottomNavigationBarItem(icon: Icon(Icons.thermostat, color: Color.fromARGB(255,42,167,73), ), label: 'Temperatura'),
        ],
        currentIndex: _paginaAtual,
        selectedItemColor: Colors.black, // Cor do item selecionado (mais forte)
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados (apagados)
        onTap: (index) {
          setState(() {
            _paginaAtual = index;
          });
        },
      ),
    );
  }
}

