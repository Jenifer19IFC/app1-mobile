import 'package:flutter/material.dart';

class ConversorMoedas extends StatefulWidget {
  const ConversorMoedas({Key? key}) : super(key: key);

  @override
  _ConversorMoedasState createState() => _ConversorMoedasState();
}

class _ConversorMoedasState extends State<ConversorMoedas> {
  // Seta valores (padrão)
  String _valorEntrada = '';
  String _valorSaida = '';
  String _moedaEntrada = 'USD';
  String _moedaSaida = 'BRL';
  String _taxaCambio = '';

  // Função para conversão 
  void converteMoeda() {
    if (_valorEntrada.isNotEmpty && _taxaCambio.isNotEmpty) {
      double valorEntrada = double.parse(_valorEntrada);
      double taxa = double.parse(_taxaCambio);

      // Cálculo de conversão
      double convertedValue = valorEntrada * taxa;

      // Atualiza estado
      setState(() {
        _valorSaida = '${convertedValue.toStringAsFixed(2)} $_moedaSaida';
      });
    } else {
      // Limpa resultado
      setState(() {
        _valorSaida = '';
      });
    }
  }

  // Sempre que um valor de entrada muda é atualizado a conversão
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header
      appBar: AppBar(
      title: const Text('Conversor de Moedas'),
      backgroundColor: const Color.fromARGB(255,42,167,73), 
      foregroundColor: Colors.white,
      centerTitle: true,            
      ),
      body: SafeArea( // Garante não sobreposição
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Campos VALOR
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Valor', 
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monetization_on),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  _valorEntrada = value;
                  converteMoeda();
                }),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Moeda de Entrada',
                        border: OutlineInputBorder(),
                      ),
                      value: _moedaEntrada,
                      items: ['USD', 'BRL', 'EUR'] 
                          .map((String currency) => DropdownMenuItem<String>(
                                value: currency,
                                child: Text(currency),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _moedaEntrada = newValue!;
                          converteMoeda();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Moeda de Saída',
                        border: OutlineInputBorder(),
                      ),
                      value: _moedaSaida,
                      items: ['USD', 'BRL', 'EUR']
                          .map((String currency) => DropdownMenuItem<String>(
                                value: currency,
                                child: Text(currency),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _moedaSaida = newValue!;
                          converteMoeda();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Taxa de Câmbio',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.currency_exchange),
                  hintText: 'Exemplo: 5.0 para 1 USD -> BRL',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  _taxaCambio = value;
                  converteMoeda();
                }),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Resultado:', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(_valorSaida, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
