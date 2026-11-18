class ResultadoSueldo {
  final double sueldoNormal;
  final double sueldoExtra;
  final double sueldoTotal;
  final double horasExtra;

  ResultadoSueldo({
    required this.sueldoNormal,
    required this.sueldoExtra,
    required this.sueldoTotal,
    required this.horasExtra,
  });
}

class CalculadoraSueldo {
  static String? validar({
    required String nombre,
    required String horasText,
    required String pagoHoraText,
  }) {
    if (nombre.trim().isEmpty ||
        horasText.trim().isEmpty ||
        pagoHoraText.trim().isEmpty) {
      return 'Por favor, completa todos los campos.';
    }

    final horas = double.tryParse(horasText.replaceAll(',', '.'));
    final pagoHora = double.tryParse(pagoHoraText.replaceAll(',', '.'));

    if (horas == null || pagoHora == null) {
      return 'Ingresa valores numéricos válidos.';
    }

    // Condición 3: No se permiten valores negativos
    if (horas < 0 || pagoHora < 0) {
      return 'No se permiten valores negativos.';
    }

    return null;
  }

  static ResultadoSueldo calcular(double horas, double pagoHora) {
    double sueldoNormal = 0;
    double sueldoExtra = 0;
    double horasExtra = 0;

    // Condición 1: Hasta 48 horas se paga tarifa normal
    if (horas <= 48) {
      sueldoNormal = horas * pagoHora;
    } else {
      // Condición 2: Más de 48 horas, las adicionales se pagan con 50% más (1.5x)
      horasExtra = horas - 48;
      sueldoNormal = 48 * pagoHora;
      sueldoExtra = horasExtra * (pagoHora * 1.5);
    }

    return ResultadoSueldo(
      sueldoNormal: sueldoNormal,
      sueldoExtra: sueldoExtra,
      sueldoTotal: sueldoNormal + sueldoExtra,
      horasExtra: horasExtra,
    );
  }
}
