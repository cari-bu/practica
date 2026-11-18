import 'package:flutter/material.dart';
import '../controllers/calculadora_combustible.dart';

class CombustibleScreen extends StatefulWidget {
  const CombustibleScreen({super.key});

  @override
  State<CombustibleScreen> createState() => _CombustibleScreenState();
}

class _CombustibleScreenState extends State<CombustibleScreen> {
  final _marcaCtrl = TextEditingController();
  final _distanciaCtrl = TextEditingController();
  final _combustibleCtrl = TextEditingController();

  ResultadoCombustible? _resultado;

  void _calcularRendimiento() {
    FocusScope.of(context).unfocus();

    final error = CalculadoraCombustible.validar(
      marca: _marcaCtrl.text,
      distanciaText: _distanciaCtrl.text,
      combustibleText: _combustibleCtrl.text,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.orange.shade800,
        ),
      );
      return;
    }

    final distancia = double.parse(_distanciaCtrl.text.replaceAll(',', '.'));
    final combustible = double.parse(_combustibleCtrl.text.replaceAll(',', '.'));

    setState(() {
      _resultado = CalculadoraCombustible.calcular(distancia, combustible);
    });
  }

  @override
  void dispose() {
    _marcaCtrl.dispose();
    _distanciaCtrl.dispose();
    _combustibleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de Combustible'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _marcaCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Marca del vehículo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _distanciaCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Distancia recorrida (km)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_road),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _combustibleCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Combustible utilizado (litros)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_gas_station),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularRendimiento,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Calcular rendimiento',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // Resultado con Center + Container
            if (_resultado != null)
              Center(
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _resultado!.esBuenRendimiento
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'VEHÍCULO',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _marcaCtrl.text.trim().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white54, height: 24),
                      const Text(
                        'RENDIMIENTO OBTENIDO',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_resultado!.rendimiento.toStringAsFixed(2)} km/L',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _resultado!.estadoRendimiento,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
