import 'package:isar/isar.dart';
import 'contacto.dart';

part 'establecimiento.g.dart';

@collection
class Establecimiento {
  Id? localId; // ID numérico auto-incremental para almacenamiento local en Isar

  @Index(unique: true, replace: true)
  final String id; // UUID String

  @Index()
  final String empresaId; // Llave foránea hacia la Empresa

  final String nombreSucursal;
  final String direccion;
  final int cantidadGuardiasEstimados;

  final List<Contacto> contactos;

  final bool isSynced;
  final DateTime updatedAt;

  Establecimiento({
    this.localId,
    required this.id,
    required this.empresaId,
    required this.nombreSucursal,
    required this.direccion,
    required this.cantidadGuardiasEstimados,
    required this.contactos,
    this.isSynced = false,
    required this.updatedAt,
  });

  Establecimiento copyWith({
    Id? localId,
    String? id,
    String? empresaId,
    String? nombreSucursal,
    String? direccion,
    int? cantidadGuardiasEstimados,
    List<Contacto>? contactos,
    bool? isSynced,
    DateTime? updatedAt,
  }) {
    return Establecimiento(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      empresaId: empresaId ?? this.empresaId,
      nombreSucursal: nombreSucursal ?? this.nombreSucursal,
      direccion: direccion ?? this.direccion,
      cantidadGuardiasEstimados: cantidadGuardiasEstimados ?? this.cantidadGuardiasEstimados,
      contactos: contactos ?? this.contactos,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Establecimiento.fromJson(Map<String, dynamic> json) => Establecimiento(
        localId: json['localId'] as int?,
        id: json['id'] as String,
        empresaId: json['empresaId'] as String,
        nombreSucursal: json['nombreSucursal'] as String,
        direccion: json['direccion'] as String,
        cantidadGuardiasEstimados: json['cantidadGuardiasEstimados'] as int,
        contactos: (json['contactos'] as List<dynamic>?)
                ?.map((e) => Contacto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        isSynced: json['isSynced'] as bool? ?? false,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        if (localId != null) 'localId': localId,
        'id': id,
        'empresaId': empresaId,
        'nombreSucursal': nombreSucursal,
        'direccion': direccion,
        'cantidadGuardiasEstimados': cantidadGuardiasEstimados,
        'contactos': contactos.map((e) => e.toJson()).toList(),
        'isSynced': isSynced,
        'updatedAt': updatedAt.toIso8601String(),
      };

  Map<String, dynamic> toSupabaseJson() => {
        'id': id,
        'empresa_id': empresaId,
        'nombre_sucursal': nombreSucursal,
        'direccion': direccion,
        'cantidad_guardias_estimados': cantidadGuardiasEstimados,
        'contactos': contactos.map((e) => e.toJson()).toList(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
