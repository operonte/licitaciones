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

  Empresa({
    this.localId,
    required this.id,
    required this.razonSocial,
    required this.rut,
    required this.rubro,
    required this.estadoRelacion,
    required this.fechaRegistro,
    this.contactos = const [],
  });

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
      };
}
