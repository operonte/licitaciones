import 'package:isar/isar.dart';

part 'licitacion.g.dart';

enum EstadoLicitacion {
  proxima,
  activa,
  presentada,
  ganada,
  perdida,
}

@collection
class Licitacion {
  Id? localId; // ID numérico auto-incremental para almacenamiento local en Isar

  @Index(unique: true, replace: true)
  final String id; // UUID String

  @Index()
  final String empresaId; // Llave foránea hacia la Empresa

  final String titulo;
  final DateTime fechaPublicacion;
  final DateTime fechaLimiteEntrega;
  final double? presupuestoEstimado;

  @enumerated
  final EstadoLicitacion estado;

  final int diasAnticipacionAlerta;

  Licitacion({
    this.localId,
    required this.id,
    required this.empresaId,
    required this.titulo,
    required this.fechaPublicacion,
    required this.fechaLimiteEntrega,
    this.presupuestoEstimado,
    required this.estado,
    required this.diasAnticipacionAlerta,
  });

  factory Licitacion.fromJson(Map<String, dynamic> json) => Licitacion(
        localId: json['localId'] as int?,
        id: json['id'] as String,
        empresaId: json['empresaId'] as String,
        titulo: json['titulo'] as String,
        fechaPublicacion: DateTime.parse(json['fechaPublicacion'] as String),
        fechaLimiteEntrega: DateTime.parse(json['fechaLimiteEntrega'] as String),
        presupuestoEstimado: json['presupuestoEstimado'] != null
            ? (json['presupuestoEstimado'] as num).toDouble()
            : null,
        estado: EstadoLicitacion.values.firstWhere(
          (e) => e.name == json['estado'],
          orElse: () => EstadoLicitacion.proxima,
        ),
        diasAnticipacionAlerta: json['diasAnticipacionAlerta'] as int,
      );

  Map<String, dynamic> toJson() => {
        if (localId != null) 'localId': localId,
        'id': id,
        'empresaId': empresaId,
        'titulo': titulo,
        'fechaPublicacion': fechaPublicacion.toIso8601String(),
        'fechaLimiteEntrega': fechaLimiteEntrega.toIso8601String(),
        'presupuestoEstimado': presupuestoEstimado,
        'estado': estado.name,
        'diasAnticipacionAlerta': diasAnticipacionAlerta,
      };
}
