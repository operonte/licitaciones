import 'package:isar/isar.dart';

part 'tarea.g.dart';

enum PrioridadTarea {
  baja,
  media,
  alta,
}

enum CategoriaTarea {
  llamada,
  email,
  visita,
  documento,
  otro,
}

enum EstadoTarea {
  pendiente,
  enProgreso,
  completada,
  cancelada,
}

@collection
class Tarea {
  Id? localId; // ID numérico auto-incremental para almacenamiento local en Isar

  @Index(unique: true, replace: true)
  final String id; // UUID String

  @Index()
  final String empresaId; // Llave foránea hacia la Empresa

  final String titulo;
  final String descripcion;

  @Index()
  final DateTime fechaVencimiento;

  @enumerated
  final PrioridadTarea prioridad;

  @enumerated
  final CategoriaTarea categoria;

  @enumerated
  final EstadoTarea estado;

  final DateTime fechaRegistro;

  Tarea({
    this.localId,
    required this.id,
    required this.empresaId,
    required this.titulo,
    this.descripcion = '',
    required this.fechaVencimiento,
    required this.prioridad,
    required this.categoria,
    required this.estado,
    required this.fechaRegistro,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        localId: json['localId'] as int?,
        id: json['id'] as String,
        empresaId: json['empresaId'] as String,
        titulo: json['titulo'] as String,
        descripcion: json['descripcion'] as String? ?? '',
        fechaVencimiento: DateTime.parse(json['fechaVencimiento'] as String),
        prioridad: PrioridadTarea.values.firstWhere(
          (e) => e.name == json['prioridad'],
          orElse: () => PrioridadTarea.media,
        ),
        categoria: CategoriaTarea.values.firstWhere(
          (e) => e.name == json['categoria'],
          orElse: () => CategoriaTarea.otro,
        ),
        estado: EstadoTarea.values.firstWhere(
          (e) => e.name == json['estado'],
          orElse: () => EstadoTarea.pendiente,
        ),
        fechaRegistro: DateTime.parse(json['fechaRegistro'] as String),
      );

  Map<String, dynamic> toJson() => {
        if (localId != null) 'localId': localId,
        'id': id,
        'empresaId': empresaId,
        'titulo': titulo,
        'descripcion': descripcion,
        'fechaVencimiento': fechaVencimiento.toIso8601String(),
        'prioridad': prioridad.name,
        'categoria': categoria.name,
        'estado': estado.name,
        'fechaRegistro': fechaRegistro.toIso8601String(),
      };
}
