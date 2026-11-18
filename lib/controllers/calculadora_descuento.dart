class ResultadoDescuento {
  final double montoDescuento;
  final double precioFinal;
  final String tipoDescuento;
  final bool esEspecial;

  ResultadoDescuento({
    required this.montoDescuento,
    required this.precioFinal,
    required this.tipoDescuento,
    required this.esEspecial,
  });
}

class CalculadoraDescuento {
  static String? validar({
    required String producto,
    required String precioText,
    required String porcentajeText,
  }) {
    if (producto.trim().isEmpty ||
        precioText.trim().isEmpty ||
        porcentajeText.trim().isEmpty) {
      return 'Por favor, completa todos los campos.';
    }

    final precio = double.tryParse(precioText.replaceAll(',', '.'));
    final porcentaje = double.tryParse(porcentajeText.replaceAll(',', '.'));

    if (precio == null || porcentaje == null) {
      return 'Ingresa valores numéricos válidos.';
    }

    // Condición 4: El precio del producto debe ser mayor que cero
    if (precio <= 0) {
      return 'El precio del producto debe ser mayor que 0.';
    }

    // Condición 3: El descuento debe estar entre 0 % y 100 %
    if (porcentaje < 0 || porcentaje > 100) {
      return 'El porcentaje de descuento debe estar entre 0 % y 100 %.';
    }

    return null;
  }

  static ResultadoDescuento calcular(double precio, double porcentaje) {
    final montoDescuento = precio * (porcentaje / 100);
    final precioFinal = precio - montoDescuento;

    // Condiciones 1 y 2: >= 20% "Descuento especial", < 20% "Descuento regular"
    final esEspecial = porcentaje >= 20;
    final tipoDescuento = esEspecial ? 'Descuento especial' : 'Descuento regular';

    return ResultadoDescuento(
      montoDescuento: montoDescuento,
      precioFinal: precioFinal,
      tipoDescuento: tipoDescuento,
      esEspecial: esEspecial,
    );
  }
}
