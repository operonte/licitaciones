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

  final bool isSynced;
  final DateTime updatedAt;

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
    this.isSynced = false,
    required this.updatedAt,
  });

  Visita copyWith({
    Id? localId,
    String? id,
    String? empresaId,
    DateTime? fechaVisita,
    TipoVisita? tipoVisita,
    String? notas,
    List<String>? temasTratados,
    ResultadoVisita? resultado,
    DateTime? proximaVisitaAgendada,
    List<String>? compromisos,
    DateTime? fechaRegistro,
    bool? isSynced,
    DateTime? updatedAt,
  }) {
    return Visita(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      empresaId: empresaId ?? this.empresaId,
      fechaVisita: fechaVisita ?? this.fechaVisita,
      tipoVisita: tipoVisita ?? this.tipoVisita,
      notas: notas ?? this.notas,
      temasTratados: temasTratados ?? this.temasTratados,
      resultado: resultado ?? this.resultado,
      proximaVisitaAgendada: proximaVisitaAgendada ?? this.proximaVisitaAgendada,
      compromisos: compromisos ?? this.compromisos,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

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
        isSynced: json['isSynced'] as bool? ?? false,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
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
        'isSynced': isSynced,
        'updatedAt': updatedAt.toIso8601String(),
      };

  Map<String, dynamic> toSupabaseJson() => {
        'id': id,
        'empresa_id': empresaId,
        'fecha_visita': fechaVisita.toIso8601String(),
        'tipo_visita': tipoVisita.name,
        'notas': notas,
        'temas_tratados': temasTratados,
        'resultado': resultado.name,
        'proxima_visita_agendada': proximaVisitaAgendada?.toIso8601String(),
        'compromisos': compromisos,
        'fecha_registro': fechaRegistro.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
