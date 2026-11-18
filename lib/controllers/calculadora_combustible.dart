class ResultadoCombustible {
  final double rendimiento;
  final String estadoRendimiento;
  final bool esBuenRendimiento;

  ResultadoCombustible({
    required this.rendimiento,
    required this.estadoRendimiento,
    required this.esBuenRendimiento,
  });
}

class CalculadoraCombustible {
  static String? validar({
    required String marca,
    required String distanciaText,
    required String combustibleText,
  }) {
    if (marca.trim().isEmpty ||
        distanciaText.trim().isEmpty ||
        combustibleText.trim().isEmpty) {
      return 'Por favor, completa todos los campos.';
    }

    final distancia = double.tryParse(distanciaText.replaceAll(',', '.'));
    final combustible = double.tryParse(combustibleText.replaceAll(',', '.'));

    if (distancia == null || combustible == null) {
      return 'Ingresa valores numéricos válidos.';
    }

    // Condición 4: La distancia y el combustible deben ser mayores que cero
    if (distancia <= 0 || combustible <= 0) {
      return 'La distancia y el combustible deben ser mayores que 0.';
    }

    return null;
  }

  static ResultadoCombustible calcular(double distancia, double combustible) {
    // Condición 1: Dividir distancia recorrida entre combustible utilizado
    final rendimiento = distancia / combustible;

    // Condiciones 2 y 3: >= 15 "Buen rendimiento", < 15 "Rendimiento bajo"
    final esBuenRendimiento = rendimiento >= 15;
    final estadoRendimiento =
        esBuenRendimiento ? 'Buen rendimiento' : 'Rendimiento bajo';

    return ResultadoCombustible(
      rendimiento: rendimiento,
      estadoRendimiento: estadoRendimiento,
      esBuenRendimiento: esBuenRendimiento,
    );
  }
}
