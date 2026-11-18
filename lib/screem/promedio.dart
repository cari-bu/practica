import 'package:flutter/material.dart';
import '../controllers/calculadora_promedio.dart';

class PromedioScreen extends StatefulWidget {
  const PromedioScreen({super.key});

  @override
  State<PromedioScreen> createState() => _PromedioScreenState();
}

class _PromedioScreenState extends State<PromedioScreen> {
  final _nombreCtrl = TextEditingController();
  final _nota1Ctrl = TextEditingController();
  final _nota2Ctrl = TextEditingController();
  final _nota3Ctrl = TextEditingController();

  String _textoPromedio = '';
  String _textoEstado = '';
  Color _colorCaja = Colors.green; // Inicia en verde como en tu ejemplo

  void _procesarCalculo() {
    FocusScope.of(context).unfocus();

    final error = CalculadoraPromedio.validarDatos(
      nombre: _nombreCtrl.text,
      n1Text: _nota1Ctrl.text,
      n2Text: _nota2Ctrl.text,
      n3Text: _nota3Ctrl.text,
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

    final n1 = double.parse(_nota1Ctrl.text.replaceAll(',', '.'));
    final n2 = double.parse(_nota2Ctrl.text.replaceAll(',', '.'));
    final n3 = double.parse(_nota3Ctrl.text.replaceAll(',', '.'));
    final resultado = CalculadoraPromedio.calcular(n1, n2, n3);

    setState(() {
      _textoPromedio = resultado.promedio.toStringAsFixed(2);
      _textoEstado = resultado.aprobado
          ? '${_nombreCtrl.text.trim()}\nAPROBADO'
          : '${_nombreCtrl.text.trim()}\nDESAPROBADO';
      // Cambia el color del Container según el resultado
      _colorCaja = resultado.aprobado ? Colors.green : Colors.red;
    });
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _nota1Ctrl.dispose();
    _nota2Ctrl.dispose();
    _nota3Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio Académico'),
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
                labelText: 'Nombre del estudiante',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nota1Ctrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 1 (0 - 20)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grade),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nota2Ctrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 2 (0 - 20)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grade),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nota3Ctrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 3 (0 - 20)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grade),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _procesarCalculo,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Calcular promedio',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // Aquí aplicamos la estructura Center + Container de tu ejemplo
            if (_textoPromedio.isNotEmpty)
              Center(
                child: Container(
                  width: 240,
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _colorCaja,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'PROMEDIO FINAL',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _textoPromedio,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _textoEstado,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
