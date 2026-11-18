import 'package:flutter/material.dart';
import '../controllers/calculadora_sueldo.dart';

class SueldoScreen extends StatefulWidget {
  const SueldoScreen({super.key});

  @override
  State<SueldoScreen> createState() => _SueldoScreenState();
}

class _SueldoScreenState extends State<SueldoScreen> {
  final _nombreCtrl = TextEditingController();
  final _horasCtrl = TextEditingController();
  final _pagoHoraCtrl = TextEditingController();

  ResultadoSueldo? _resultado;

  void _calcularSueldo() {
    FocusScope.of(context).unfocus();

    final error = CalculadoraSueldo.validar(
      nombre: _nombreCtrl.text,
      horasText: _horasCtrl.text,
      pagoHoraText: _pagoHoraCtrl.text,
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

    final horas = double.parse(_horasCtrl.text.replaceAll(',', '.'));
    final pagoHora = double.parse(_pagoHoraCtrl.text.replaceAll(',', '.'));

    setState(() {
      _resultado = CalculadoraSueldo.calcular(horas, pagoHora);
    });
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _horasCtrl.dispose();
    _pagoHoraCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sueldo Semanal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nombreCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nombre del trabajador',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _horasCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Horas trabajadas en la semana',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pagoHoraCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Pago por hora (S/)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularSueldo,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Calcular sueldo',
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
                    color: _resultado!.horasExtra > 0 ? Colors.green.shade700 : Colors.indigo,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'TRABAJADOR',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _nombreCtrl.text.trim().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white54, height: 20),
                      Text(
                        'Pago normal: S/ ${_resultado!.sueldoNormal.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      if (_resultado!.horasExtra > 0)
                        Text(
                          'Horas extra (${_resultado!.horasExtra.toStringAsFixed(1)}h): S/ ${_resultado!.sueldoExtra.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      const SizedBox(height: 12),
                      const Text(
                        'SUELDO TOTAL',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        'S/ ${_resultado!.sueldoTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
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
