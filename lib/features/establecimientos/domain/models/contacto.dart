import 'package:isar/isar.dart';

part 'contacto.g.dart';

@embedded
class Contacto {
  String? nombre;
  String? cargo;
  String? telefono;
  String? email;

  Contacto({
    this.nombre,
    this.cargo,
    this.telefono,
    this.email,
  });

  factory Contacto.fromJson(Map<String, dynamic> json) => Contacto(
        nombre: json['nombre'] as String?,
        cargo: json['cargo'] as String?,
        telefono: json['telefono'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'cargo': cargo,
        'telefono': telefono,
        'email': email,
      };
}
