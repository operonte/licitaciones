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

  Establecimiento({
    this.localId,
    required this.id,
    required this.empresaId,
    required this.nombreSucursal,
    required this.direccion,
    required this.cantidadGuardiasEstimados,
    required this.contactos,
  });

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
      );

  Map<String, dynamic> toJson() => {
        if (localId != null) 'localId': localId,
        'id': id,
        'empresaId': empresaId,
        'nombreSucursal': nombreSucursal,
        'direccion': direccion,
        'cantidadGuardiasEstimados': cantidadGuardiasEstimados,
        'contactos': contactos.map((e) => e.toJson()).toList(),
      };
}
