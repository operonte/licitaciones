import 'package:isar/isar.dart';
import 'package:licitaciones/features/establecimientos/domain/models/contacto.dart';

part 'empresa.g.dart';

enum EstadoRelacion {
  prospecto,
  asesorado,
  enLicitacion,
  clienteActivo,
}

@collection
class Empresa {
  Id? localId; // ID numérico auto-incremental para almacenamiento local en Isar

  @Index(unique: true, replace: true)
  final String id; // UUID String para lógica de negocio e integración offline-first

  final String razonSocial;
  final String rut;
  final String rubro;

  @enumerated
  final EstadoRelacion estadoRelacion;

  final DateTime fechaRegistro;

  /// Contactos de la empresa (máximo 3)
  final List<Contacto> contactos;

  /// Notas de visitas y seguimiento comercial
  final String notasVisita;

  final bool isSynced;
  final DateTime updatedAt;

  Empresa({
    this.localId,
    required this.id,
    required this.razonSocial,
    required this.rut,
    required this.rubro,
    required this.estadoRelacion,
    required this.fechaRegistro,
    this.contactos = const [],
    this.notasVisita = '',
    this.isSynced = false,
    required this.updatedAt,
  });

  Empresa copyWith({
    Id? localId,
    String? id,
    String? razonSocial,
    String? rut,
    String? rubro,
    EstadoRelacion? estadoRelacion,
    DateTime? fechaRegistro,
    List<Contacto>? contactos,
    String? notasVisita,
    bool? isSynced,
    DateTime? updatedAt,
  }) {
    return Empresa(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      razonSocial: razonSocial ?? this.razonSocial,
      rut: rut ?? this.rut,
      rubro: rubro ?? this.rubro,
      estadoRelacion: estadoRelacion ?? this.estadoRelacion,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      contactos: contactos ?? this.contactos,
      notasVisita: notasVisita ?? this.notasVisita,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        localId: json['localId'] as int?,
        id: json['id'] as String,
        razonSocial: json['razonSocial'] as String,
        rut: json['rut'] as String,
        rubro: json['rubro'] as String,
        estadoRelacion: EstadoRelacion.values.firstWhere(
          (e) => e.name == json['estadoRelacion'],
          orElse: () => EstadoRelacion.prospecto,
        ),
        fechaRegistro: DateTime.parse(json['fechaRegistro'] as String),
        contactos: (json['contactos'] as List<dynamic>?)
                ?.map((c) => Contacto.fromJson(c as Map<String, dynamic>))
                .toList() ??
            [],
        notasVisita: json['notasVisita'] as String? ?? '',
        isSynced: json['isSynced'] as bool? ?? false,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : (json['fechaRegistro'] != null
                ? DateTime.parse(json['fechaRegistro'] as String)
                : DateTime.now()),
      );

  Map<String, dynamic> toJson() => {
        if (localId != null) 'localId': localId,
        'id': id,
        'razonSocial': razonSocial,
        'rut': rut,
        'rubro': rubro,
        'estadoRelacion': estadoRelacion.name,
        'fechaRegistro': fechaRegistro.toIso8601String(),
        'contactos': contactos.map((c) => c.toJson()).toList(),
        'notasVisita': notasVisita,
        'isSynced': isSynced,
        'updatedAt': updatedAt.toIso8601String(),
      };

  Map<String, dynamic> toSupabaseJson() => {
        'id': id,
        'razon_social': razonSocial,
        'rut': rut,
        'rubro': rubro,
        'estado_relacion': estadoRelacion.name,
        'fecha_registro': fechaRegistro.toIso8601String(),
        'contactos': contactos.map((c) => c.toJson()).toList(),
        'notas_visita': notasVisita,
        'updated_at': updatedAt.toIso8601String(),
      };
}
