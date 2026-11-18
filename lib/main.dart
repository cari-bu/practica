import 'package:flutter/material.dart';
import 'package:practica/screem/combustible_screen.dart';
import 'package:practica/screem/descuento_screen.dart';
import 'package:practica/screem/sueldo_screen.dart';
import 'screem/promedio.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Académica',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ScreenFormulario(),
    );
  }
}
