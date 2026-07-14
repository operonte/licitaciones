import 'package:isar/isar.dart';

part 'visita.g.dart';

enum TipoVisita {
  primera,
  seguimiento,
  cierre,
  postVenta,
}

enum ResultadoVisita {
  interesado,
  noInteresado,
  pendiente,
  contratoFirmado,
}

@collection
class Visita {
  Id? localId; // ID numérico auto-incremental para almacenamiento local en Isar

  @Index(unique: true, replace: true)
  final String id; // UUID String

  @Index()
  final String empresaId; // Llave foránea hacia la Empresa

  @Index()
  final DateTime fechaVisita;

  @enumerated
  final TipoVisita tipoVisita;

  final String notas;

  final List<String> temasTratados;

  @enumerated
  final ResultadoVisita resultado;

  final DateTime? proximaVisitaAgendada;

  final List<String> compromisos;

  final DateTime fechaRegistro;

  Visita({
    this.localId,
    required this.id,
    required this.empresaId,
    required this.fechaVisita,
    required this.tipoVisita,
    this.notas = '',
    this.temasTratados = const [],
    required this.resultado,
    this.proximaVisitaAgendada,
    this.compromisos = const [],
    required this.fechaRegistro,
  });

  factory Visita.fromJson(Map<String, dynamic> json) => Visita(
        localId: json['localId'] as int?,
        id: json['id'] as String,
        empresaId: json['empresaId'] as String,
        fechaVisita: DateTime.parse(json['fechaVisita'] as String),
        tipoVisita: TipoVisita.values.firstWhere(
          (e) => e.name == json['tipoVisita'],
          orElse: () => TipoVisita.primera,
        ),
        notas: json['notas'] as String? ?? '',
        temasTratados: (json['temasTratados'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        resultado: ResultadoVisita.values.firstWhere(
          (e) => e.name == json['resultado'],
          orElse: () => ResultadoVisita.pendiente,
        ),
        proximaVisitaAgendada: json['proximaVisitaAgendada'] != null
            ? DateTime.parse(json['proximaVisitaAgendada'] as String)
            : null,
        compromisos: (json['compromisos'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        fechaRegistro: DateTime.parse(json['fechaRegistro'] as String),
      );

  Map<String, dynamic> toJson() => {
        if (localId != null) 'localId': localId,
        'id': id,
        'empresaId': empresaId,
        'fechaVisita': fechaVisita.toIso8601String(),
        'tipoVisita': tipoVisita.name,
        'notas': notas,
        'temasTratados': temasTratados,
        'resultado': resultado.name,
        'proximaVisitaAgendada': proximaVisitaAgendada?.toIso8601String(),
        'compromisos': compromisos,
        'fechaRegistro': fechaRegistro.toIso8601String(),
      };
}
