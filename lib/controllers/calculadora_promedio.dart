class ResultadoAcademico {
  final double promedio;
  final bool aprobado;

  ResultadoAcademico({required this.promedio, required this.aprobado});
}

class CalculadoraPromedio {
  static String? validarDatos({
    required String nombre,
    required String n1Text,
    required String n2Text,
    required String n3Text,
  }) {
    if (nombre.trim().isEmpty ||
        n1Text.trim().isEmpty ||
        n2Text.trim().isEmpty ||
        n3Text.trim().isEmpty) {
      return 'Por favor, completa todos los campos.';
    }

    final n1 = double.tryParse(n1Text.replaceAll(',', '.'));
    final n2 = double.tryParse(n2Text.replaceAll(',', '.'));
    final n3 = double.tryParse(n3Text.replaceAll(',', '.'));

    if (n1 == null || n2 == null || n3 == null) {
      return 'Ingresa valores numéricos válidos.';
    }

    if (n1 < 0 || n1 > 20 || n2 < 0 || n2 > 20 || n3 < 0 || n3 > 20) {
      return 'Las notas deben estar entre 0 y 20.';
    }

    return null;
  }

  static ResultadoAcademico calcular(double n1, double n2, double n3) {
    final promedio = (n1 + n2 + n3) / 3;
    return ResultadoAcademico(
      promedio: promedio,
      aprobado: promedio >= 13,
    );
  }
}
