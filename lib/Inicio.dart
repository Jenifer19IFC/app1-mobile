import 'package:flutter/material.dart';
import 'package:projeto/ConversorMoedas.dart';
import 'package:projeto/ConversorTemperatura.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text(
          'Página Inicial',
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2AA749),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // Corpo da tela
      body: Container(
        color: Colors.white, // Fundo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mensagem introdutória
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Navegue clicando nos ícones ou abas abaixo.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                ),
              ),
              const SizedBox(height: 40),
              // Ícones de navegação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavigationCard(
                    context,
                    'Conversor de Moedas',
                    'imgs/moeda.png',
                    const ConversorMoedas(),
                  ),
                  _buildNavigationCard(
                    context,
                    'Conversor de Temperatura',
                    'imgs/temperatura.png',
                    const ConversorTemperatura(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir um cartão de navegação 
  Widget _buildNavigationCard(
      BuildContext context, String label, String imagePath, Widget destination) {
    return GestureDetector(
      onTap: () {
        // Navega para a tela correspondente ao clicar 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Column(
        children: [
          // Imagem no formato circular
          ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 180,
              height: 180,
            ),
          ),
          const SizedBox(height: 10),
          // Texto abaixo do ícone
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }
}
