import 'package:flutter/material.dart';
import '../controllers/calculadora_descuento.dart';

class DescuentoScreen extends StatefulWidget {
  const DescuentoScreen({super.key});

  @override
  State<DescuentoScreen> createState() => _DescuentoScreenState();
}

class _DescuentoScreenState extends State<DescuentoScreen> {
  final _productoCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  final _porcentajeCtrl = TextEditingController();

  ResultadoDescuento? _resultado;

  void _calcularDescuento() {
    FocusScope.of(context).unfocus();

    final error = CalculadoraDescuento.validar(
      producto: _productoCtrl.text,
      precioText: _precioCtrl.text,
      porcentajeText: _porcentajeCtrl.text,
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

    final precio = double.parse(_precioCtrl.text.replaceAll(',', '.'));
    final porcentaje = double.parse(_porcentajeCtrl.text.replaceAll(',', '.'));

    setState(() {
      _resultado = CalculadoraDescuento.calcular(precio, porcentaje);
    });
  }

  @override
  void dispose() {
    _productoCtrl.dispose();
    _precioCtrl.dispose();
    _porcentajeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descuento de Productos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _productoCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _precioCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Precio del producto (S/)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _porcentajeCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Porcentaje de descuento (0 - 100 %)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.percent),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularDescuento,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Calcular descuento',
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
                    color: _resultado!.esEspecial ? Colors.teal.shade700 : Colors.blueGrey.shade700,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _productoCtrl.text.trim().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _resultado!.tipoDescuento,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.white54, height: 24),
                      Text(
                        'Descuento aplicado: S/ ${_resultado!.montoDescuento.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'PRECIO FINAL',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        'S/ ${_resultado!.precioFinal.toStringAsFixed(2)}',
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
