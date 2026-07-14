// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visita.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVisitaCollection on Isar {
  IsarCollection<Visita> get visitas => this.collection();
}

const VisitaSchema = CollectionSchema(
  name: r'Visita',
  id: 9010560764975869961,
  properties: {
    r'compromisos': PropertySchema(
      id: 0,
      name: r'compromisos',
      type: IsarType.stringList,
    ),
    r'empresaId': PropertySchema(
      id: 1,
      name: r'empresaId',
      type: IsarType.string,
    ),
    r'fechaRegistro': PropertySchema(
      id: 2,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'fechaVisita': PropertySchema(
      id: 3,
      name: r'fechaVisita',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 5,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'notas': PropertySchema(
      id: 6,
      name: r'notas',
      type: IsarType.string,
    ),
    r'proximaVisitaAgendada': PropertySchema(
      id: 7,
      name: r'proximaVisitaAgendada',
      type: IsarType.dateTime,
    ),
    r'resultado': PropertySchema(
      id: 8,
      name: r'resultado',
      type: IsarType.byte,
      enumMap: _VisitaresultadoEnumValueMap,
    ),
    r'temasTratados': PropertySchema(
      id: 9,
      name: r'temasTratados',
      type: IsarType.stringList,
    ),
    r'tipoVisita': PropertySchema(
      id: 10,
      name: r'tipoVisita',
      type: IsarType.byte,
      enumMap: _VisitatipoVisitaEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 11,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _visitaEstimateSize,
  serialize: _visitaSerialize,
  deserialize: _visitaDeserialize,
  deserializeProp: _visitaDeserializeProp,
  idName: r'localId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'empresaId': IndexSchema(
      id: 4061495233042072508,
      name: r'empresaId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'empresaId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'fechaVisita': IndexSchema(
      id: -827337780703803425,
      name: r'fechaVisita',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fechaVisita',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _visitaGetId,
  getLinks: _visitaGetLinks,
  attach: _visitaAttach,
  version: '3.1.0+1',
);

int _visitaEstimateSize(
  Visita object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.compromisos.length * 3;
  {
    for (var i = 0; i < object.compromisos.length; i++) {
      final value = object.compromisos[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.empresaId.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.notas.length * 3;
  bytesCount += 3 + object.temasTratados.length * 3;
  {
    for (var i = 0; i < object.temasTratados.length; i++) {
      final value = object.temasTratados[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _visitaSerialize(
  Visita object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.compromisos);
  writer.writeString(offsets[1], object.empresaId);
  writer.writeDateTime(offsets[2], object.fechaRegistro);
  writer.writeDateTime(offsets[3], object.fechaVisita);
  writer.writeString(offsets[4], object.id);
  writer.writeBool(offsets[5], object.isSynced);
  writer.writeString(offsets[6], object.notas);
  writer.writeDateTime(offsets[7], object.proximaVisitaAgendada);
  writer.writeByte(offsets[8], object.resultado.index);
  writer.writeStringList(offsets[9], object.temasTratados);
  writer.writeByte(offsets[10], object.tipoVisita.index);
  writer.writeDateTime(offsets[11], object.updatedAt);
}

Visita _visitaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Visita(
    compromisos: reader.readStringList(offsets[0]) ?? const [],
    empresaId: reader.readString(offsets[1]),
    fechaRegistro: reader.readDateTime(offsets[2]),
    fechaVisita: reader.readDateTime(offsets[3]),
    id: reader.readString(offsets[4]),
    isSynced: reader.readBoolOrNull(offsets[5]) ?? false,
    localId: id,
    notas: reader.readStringOrNull(offsets[6]) ?? '',
    proximaVisitaAgendada: reader.readDateTimeOrNull(offsets[7]),
    resultado:
        _VisitaresultadoValueEnumMap[reader.readByteOrNull(offsets[8])] ??
            ResultadoVisita.interesado,
    temasTratados: reader.readStringList(offsets[9]) ?? const [],
    tipoVisita:
        _VisitatipoVisitaValueEnumMap[reader.readByteOrNull(offsets[10])] ??
            TipoVisita.primera,
    updatedAt: reader.readDateTime(offsets[11]),
  );
  return object;
}

P _visitaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? const []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (_VisitaresultadoValueEnumMap[reader.readByteOrNull(offset)] ??
          ResultadoVisita.interesado) as P;
    case 9:
      return (reader.readStringList(offset) ?? const []) as P;
    case 10:
      return (_VisitatipoVisitaValueEnumMap[reader.readByteOrNull(offset)] ??
          TipoVisita.primera) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _VisitaresultadoEnumValueMap = {
  'interesado': 0,
  'noInteresado': 1,
  'pendiente': 2,
  'contratoFirmado': 3,
};
const _VisitaresultadoValueEnumMap = {
  0: ResultadoVisita.interesado,
  1: ResultadoVisita.noInteresado,
  2: ResultadoVisita.pendiente,
  3: ResultadoVisita.contratoFirmado,
};
const _VisitatipoVisitaEnumValueMap = {
  'primera': 0,
  'seguimiento': 1,
  'cierre': 2,
  'postVenta': 3,
};
const _VisitatipoVisitaValueEnumMap = {
  0: TipoVisita.primera,
  1: TipoVisita.seguimiento,
  2: TipoVisita.cierre,
  3: TipoVisita.postVenta,
};

Id _visitaGetId(Visita object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _visitaGetLinks(Visita object) {
  return [];
}

void _visitaAttach(IsarCollection<dynamic> col, Id id, Visita object) {
  object.localId = id;
}

extension VisitaByIndex on IsarCollection<Visita> {
  Future<Visita?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  Visita? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<Visita?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<Visita?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(Visita object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(Visita object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<Visita> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<Visita> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension VisitaQueryWhereSort on QueryBuilder<Visita, Visita, QWhere> {
  QueryBuilder<Visita, Visita, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhere> anyFechaVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fechaVisita'),
      );
    });
  }
}

extension VisitaQueryWhere on QueryBuilder<Visita, Visita, QWhereClause> {
  QueryBuilder<Visita, Visita, QAfterWhereClause> localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> localIdNotEqualTo(
      Id localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> localIdGreaterThan(Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> localIdLessThan(Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> localIdBetween(
    Id lowerLocalId,
    Id upperLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalId,
        includeLower: includeLower,
        upper: upperLocalId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> empresaIdEqualTo(
      String empresaId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'empresaId',
        value: [empresaId],
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> empresaIdNotEqualTo(
      String empresaId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'empresaId',
              lower: [],
              upper: [empresaId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'empresaId',
              lower: [empresaId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'empresaId',
              lower: [empresaId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'empresaId',
              lower: [],
              upper: [empresaId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> fechaVisitaEqualTo(
      DateTime fechaVisita) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fechaVisita',
        value: [fechaVisita],
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> fechaVisitaNotEqualTo(
      DateTime fechaVisita) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaVisita',
              lower: [],
              upper: [fechaVisita],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaVisita',
              lower: [fechaVisita],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaVisita',
              lower: [fechaVisita],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaVisita',
              lower: [],
              upper: [fechaVisita],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> fechaVisitaGreaterThan(
    DateTime fechaVisita, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaVisita',
        lower: [fechaVisita],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> fechaVisitaLessThan(
    DateTime fechaVisita, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaVisita',
        lower: [],
        upper: [fechaVisita],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterWhereClause> fechaVisitaBetween(
    DateTime lowerFechaVisita,
    DateTime upperFechaVisita, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaVisita',
        lower: [lowerFechaVisita],
        includeLower: includeLower,
        upper: [upperFechaVisita],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VisitaQueryFilter on QueryBuilder<Visita, Visita, QFilterCondition> {
  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compromisos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compromisos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compromisos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compromisos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'compromisos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'compromisos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'compromisos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'compromisos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compromisos',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'compromisos',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compromisos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compromisos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compromisos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compromisos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      compromisosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compromisos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> compromisosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'compromisos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'empresaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'empresaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'empresaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'empresaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'empresaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'empresaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'empresaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'empresaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'empresaId',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> empresaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'empresaId',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaRegistroEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaRegistroGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaRegistroLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaRegistroBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaRegistro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaVisitaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaVisita',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaVisitaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaVisita',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaVisitaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaVisita',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> fechaVisitaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaVisita',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> localIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> localIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> localIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> localIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      proximaVisitaAgendadaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proximaVisitaAgendada',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      proximaVisitaAgendadaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proximaVisitaAgendada',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      proximaVisitaAgendadaEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proximaVisitaAgendada',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      proximaVisitaAgendadaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proximaVisitaAgendada',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      proximaVisitaAgendadaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proximaVisitaAgendada',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      proximaVisitaAgendadaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proximaVisitaAgendada',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> resultadoEqualTo(
      ResultadoVisita value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resultado',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> resultadoGreaterThan(
    ResultadoVisita value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resultado',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> resultadoLessThan(
    ResultadoVisita value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resultado',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> resultadoBetween(
    ResultadoVisita lower,
    ResultadoVisita upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resultado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temasTratados',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temasTratados',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temasTratados',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temasTratados',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'temasTratados',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'temasTratados',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'temasTratados',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'temasTratados',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temasTratados',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'temasTratados',
        value: '',
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'temasTratados',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> temasTratadosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'temasTratados',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'temasTratados',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'temasTratados',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'temasTratados',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition>
      temasTratadosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'temasTratados',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> tipoVisitaEqualTo(
      TipoVisita value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoVisita',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> tipoVisitaGreaterThan(
    TipoVisita value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoVisita',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> tipoVisitaLessThan(
    TipoVisita value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoVisita',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> tipoVisitaBetween(
    TipoVisita lower,
    TipoVisita upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoVisita',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Visita, Visita, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VisitaQueryObject on QueryBuilder<Visita, Visita, QFilterCondition> {}

extension VisitaQueryLinks on QueryBuilder<Visita, Visita, QFilterCondition> {}

extension VisitaQuerySortBy on QueryBuilder<Visita, Visita, QSortBy> {
  QueryBuilder<Visita, Visita, QAfterSortBy> sortByEmpresaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByEmpresaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByFechaVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVisita', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByFechaVisitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVisita', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByProximaVisitaAgendada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaVisitaAgendada', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByProximaVisitaAgendadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaVisitaAgendada', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByResultado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultado', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByResultadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultado', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByTipoVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoVisita', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByTipoVisitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoVisita', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension VisitaQuerySortThenBy on QueryBuilder<Visita, Visita, QSortThenBy> {
  QueryBuilder<Visita, Visita, QAfterSortBy> thenByEmpresaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByEmpresaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByFechaVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVisita', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByFechaVisitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaVisita', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByProximaVisitaAgendada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaVisitaAgendada', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByProximaVisitaAgendadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximaVisitaAgendada', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByResultado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultado', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByResultadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resultado', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByTipoVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoVisita', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByTipoVisitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoVisita', Sort.desc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Visita, Visita, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension VisitaQueryWhereDistinct on QueryBuilder<Visita, Visita, QDistinct> {
  QueryBuilder<Visita, Visita, QDistinct> distinctByCompromisos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compromisos');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByEmpresaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'empresaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByFechaVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaVisita');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByProximaVisitaAgendada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proximaVisitaAgendada');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByResultado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resultado');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByTemasTratados() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temasTratados');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByTipoVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoVisita');
    });
  }

  QueryBuilder<Visita, Visita, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension VisitaQueryProperty on QueryBuilder<Visita, Visita, QQueryProperty> {
  QueryBuilder<Visita, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<Visita, List<String>, QQueryOperations> compromisosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compromisos');
    });
  }

  QueryBuilder<Visita, String, QQueryOperations> empresaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'empresaId');
    });
  }

  QueryBuilder<Visita, DateTime, QQueryOperations> fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<Visita, DateTime, QQueryOperations> fechaVisitaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaVisita');
    });
  }

  QueryBuilder<Visita, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Visita, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<Visita, String, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<Visita, DateTime?, QQueryOperations>
      proximaVisitaAgendadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proximaVisitaAgendada');
    });
  }

  QueryBuilder<Visita, ResultadoVisita, QQueryOperations> resultadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resultado');
    });
  }

  QueryBuilder<Visita, List<String>, QQueryOperations> temasTratadosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temasTratados');
    });
  }

  QueryBuilder<Visita, TipoVisita, QQueryOperations> tipoVisitaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoVisita');
    });
  }

  QueryBuilder<Visita, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
