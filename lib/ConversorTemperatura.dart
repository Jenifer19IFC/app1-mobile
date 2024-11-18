import 'package:flutter/material.dart';

class ConversorTemperatura extends StatefulWidget {
  const ConversorTemperatura({Key? key}) : super(key: key);

  @override
  _ConversorTemperaturaState createState() => _ConversorTemperaturaState();
}

class _ConversorTemperaturaState extends State<ConversorTemperatura> {
  // Seta valores (padrão)
  String _valorEntrada = '';
  String _valorSaida = '';
  String _unidEntrada = 'Celsius';
  String _unidSaida = 'Celsius';

  // Função para conversão
  void convertTemperature() {
    if (_valorEntrada.isNotEmpty) {
      double valorEntrada = double.parse(_valorEntrada);
      
      switch (_unidEntrada) {
        case 'Celsius':
          switch (_unidSaida) {
            case 'Celsius':
              _valorSaida = '${valorEntrada.toStringAsFixed(2)} °C';
              break;
            case 'Fahrenheit':
              _valorSaida = ((valorEntrada * 9 / 5) + 32).toStringAsFixed(2) + ' °F';
              break;
            case 'Kelvin':
              _valorSaida = (valorEntrada + 273.15).toStringAsFixed(2) + ' K';
              break;
          }
          break;
        case 'Fahrenheit':
          switch (_unidSaida) {
            case 'Celsius':
              _valorSaida = ((valorEntrada - 32) * 5 / 9).toStringAsFixed(2) + ' °C';
              break;
            case 'Fahrenheit':
              _valorSaida = valorEntrada.toStringAsFixed(2) + ' °F';
              break;
            case 'Kelvin':
              _valorSaida = ((valorEntrada - 32) * 5 / 9 + 273.15).toStringAsFixed(2) + ' K';
              break;
          }
          break;
        case 'Kelvin':
          switch (_unidSaida) {
            case 'Celsius':
              _valorSaida = (valorEntrada - 273.15).toStringAsFixed(2) + ' °C';
              break;
            case 'Fahrenheit':
              _valorSaida = ((valorEntrada - 273.15) * 9 / 5 + 32).toStringAsFixed(2) + ' °F';
              break;
            case 'Kelvin':
              _valorSaida = valorEntrada.toStringAsFixed(2) + ' K';
              break;
          }
          break;
      }
    } else {
      _valorSaida = '';
    }
  }

   // Sempre que um valor de entrada muda é atualizado a conversão
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header
      appBar: AppBar(
        title: Text('Conversor de Temperatura'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,42,167,73), 
        foregroundColor: Colors.white,
      ),
      body: SafeArea( // Garante não sobreposição
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.thermostat_auto_outlined),
                ),
                onChanged: (value) => _valorEntrada = value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Unidade de Entrada',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Celsius', 'Fahrenheit', 'Kelvin'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value),
                              Icon(Icons.arrow_drop_down_circle),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _unidEntrada = newValue!;
                          _valorSaida = '';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Unidade de Saída',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Celsius', 'Fahrenheit', 'Kelvin'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value),
                              Icon(Icons.arrow_drop_down_circle),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _unidSaida = newValue!;
                          convertTemperature();
                        });
                      },
                    ),
                  ),
                ],
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
