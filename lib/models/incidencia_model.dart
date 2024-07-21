class Incidencia {
  final int? id;
  final String titulo;
  final DateTime fecha;
  final String descripcion;
  final String? fotoPath;
  final String? audioPath;

  Incidencia({
    this.id,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    this.fotoPath,
    this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'fecha': fecha.toIso8601String(),
      'descripcion': descripcion,
      'fotoPath': fotoPath,
      'audioPath': audioPath,
    };
  }
}
