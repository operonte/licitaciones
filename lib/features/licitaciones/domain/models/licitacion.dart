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

  final bool isSynced;
  final DateTime updatedAt;

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
    this.isSynced = false,
    required this.updatedAt,
  });

  Licitacion copyWith({
    Id? localId,
    String? id,
    String? empresaId,
    String? titulo,
    DateTime? fechaPublicacion,
    DateTime? fechaLimiteEntrega,
    double? presupuestoEstimado,
    EstadoLicitacion? estado,
    int? diasAnticipacionAlerta,
    bool? isSynced,
    DateTime? updatedAt,
  }) {
    return Licitacion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      empresaId: empresaId ?? this.empresaId,
      titulo: titulo ?? this.titulo,
      fechaPublicacion: fechaPublicacion ?? this.fechaPublicacion,
      fechaLimiteEntrega: fechaLimiteEntrega ?? this.fechaLimiteEntrega,
      presupuestoEstimado: presupuestoEstimado ?? this.presupuestoEstimado,
      estado: estado ?? this.estado,
      diasAnticipacionAlerta: diasAnticipacionAlerta ?? this.diasAnticipacionAlerta,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

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
        isSynced: json['isSynced'] as bool? ?? false,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
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
        'isSynced': isSynced,
        'updatedAt': updatedAt.toIso8601String(),
      };

  Map<String, dynamic> toSupabaseJson() => {
        'id': id,
        'empresa_id': empresaId,
        'titulo': titulo,
        'fecha_publicacion': fechaPublicacion.toIso8601String(),
        'fecha_limite_entrega': fechaLimiteEntrega.toIso8601String(),
        'presupuesto_estimado': presupuestoEstimado,
        'estado': estado.name,
        'dias_anticipacion_alerta': diasAnticipacionAlerta,
        'updated_at': updatedAt.toIso8601String(),
      };
}
