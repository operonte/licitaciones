// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licitacion.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLicitacionCollection on Isar {
  IsarCollection<Licitacion> get licitacions => this.collection();
}

const LicitacionSchema = CollectionSchema(
  name: r'Licitacion',
  id: 3698832080836963028,
  properties: {
    r'diasAnticipacionAlerta': PropertySchema(
      id: 0,
      name: r'diasAnticipacionAlerta',
      type: IsarType.long,
    ),
    r'empresaId': PropertySchema(
      id: 1,
      name: r'empresaId',
      type: IsarType.string,
    ),
    r'estado': PropertySchema(
      id: 2,
      name: r'estado',
      type: IsarType.byte,
      enumMap: _LicitacionestadoEnumValueMap,
    ),
    r'fechaLimiteEntrega': PropertySchema(
      id: 3,
      name: r'fechaLimiteEntrega',
      type: IsarType.dateTime,
    ),
    r'fechaPublicacion': PropertySchema(
      id: 4,
      name: r'fechaPublicacion',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'presupuestoEstimado': PropertySchema(
      id: 6,
      name: r'presupuestoEstimado',
      type: IsarType.double,
    ),
    r'titulo': PropertySchema(
      id: 7,
      name: r'titulo',
      type: IsarType.string,
    )
  },
  estimateSize: _licitacionEstimateSize,
  serialize: _licitacionSerialize,
  deserialize: _licitacionDeserialize,
  deserializeProp: _licitacionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _licitacionGetId,
  getLinks: _licitacionGetLinks,
  attach: _licitacionAttach,
  version: '3.1.0+1',
);

int _licitacionEstimateSize(
  Licitacion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.empresaId.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.titulo.length * 3;
  return bytesCount;
}

void _licitacionSerialize(
  Licitacion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.diasAnticipacionAlerta);
  writer.writeString(offsets[1], object.empresaId);
  writer.writeByte(offsets[2], object.estado.index);
  writer.writeDateTime(offsets[3], object.fechaLimiteEntrega);
  writer.writeDateTime(offsets[4], object.fechaPublicacion);
  writer.writeString(offsets[5], object.id);
  writer.writeDouble(offsets[6], object.presupuestoEstimado);
  writer.writeString(offsets[7], object.titulo);
}

Licitacion _licitacionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Licitacion(
    diasAnticipacionAlerta: reader.readLong(offsets[0]),
    empresaId: reader.readString(offsets[1]),
    estado: _LicitacionestadoValueEnumMap[reader.readByteOrNull(offsets[2])] ??
        EstadoLicitacion.proxima,
    fechaLimiteEntrega: reader.readDateTime(offsets[3]),
    fechaPublicacion: reader.readDateTime(offsets[4]),
    id: reader.readString(offsets[5]),
    localId: id,
    presupuestoEstimado: reader.readDoubleOrNull(offsets[6]),
    titulo: reader.readString(offsets[7]),
  );
  return object;
}

P _licitacionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (_LicitacionestadoValueEnumMap[reader.readByteOrNull(offset)] ??
          EstadoLicitacion.proxima) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LicitacionestadoEnumValueMap = {
  'proxima': 0,
  'activa': 1,
  'presentada': 2,
  'ganada': 3,
  'perdida': 4,
};
const _LicitacionestadoValueEnumMap = {
  0: EstadoLicitacion.proxima,
  1: EstadoLicitacion.activa,
  2: EstadoLicitacion.presentada,
  3: EstadoLicitacion.ganada,
  4: EstadoLicitacion.perdida,
};

Id _licitacionGetId(Licitacion object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _licitacionGetLinks(Licitacion object) {
  return [];
}

void _licitacionAttach(IsarCollection<dynamic> col, Id id, Licitacion object) {
  object.localId = id;
}

extension LicitacionByIndex on IsarCollection<Licitacion> {
  Future<Licitacion?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  Licitacion? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<Licitacion?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<Licitacion?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(Licitacion object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(Licitacion object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<Licitacion> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<Licitacion> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension LicitacionQueryWhereSort
    on QueryBuilder<Licitacion, Licitacion, QWhere> {
  QueryBuilder<Licitacion, Licitacion, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LicitacionQueryWhere
    on QueryBuilder<Licitacion, Licitacion, QWhereClause> {
  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> localIdEqualTo(
      Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> localIdNotEqualTo(
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

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> localIdGreaterThan(
      Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> localIdLessThan(
      Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> localIdBetween(
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

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> idNotEqualTo(
      String id) {
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

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> empresaIdEqualTo(
      String empresaId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'empresaId',
        value: [empresaId],
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterWhereClause> empresaIdNotEqualTo(
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
}

extension LicitacionQueryFilter
    on QueryBuilder<Licitacion, Licitacion, QFilterCondition> {
  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      diasAnticipacionAlertaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diasAnticipacionAlerta',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      diasAnticipacionAlertaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diasAnticipacionAlerta',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      diasAnticipacionAlertaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diasAnticipacionAlerta',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      diasAnticipacionAlertaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diasAnticipacionAlerta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> empresaIdEqualTo(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      empresaIdGreaterThan(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> empresaIdLessThan(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> empresaIdBetween(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      empresaIdStartsWith(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> empresaIdEndsWith(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> empresaIdContains(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> empresaIdMatches(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      empresaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'empresaId',
        value: '',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      empresaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'empresaId',
        value: '',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> estadoEqualTo(
      EstadoLicitacion value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> estadoGreaterThan(
    EstadoLicitacion value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> estadoLessThan(
    EstadoLicitacion value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estado',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> estadoBetween(
    EstadoLicitacion lower,
    EstadoLicitacion upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaLimiteEntregaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaLimiteEntrega',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaLimiteEntregaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaLimiteEntrega',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaLimiteEntregaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaLimiteEntrega',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaLimiteEntregaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaLimiteEntrega',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaPublicacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaPublicacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaPublicacionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaPublicacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaPublicacionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaPublicacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      fechaPublicacionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaPublicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> localIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      localIdGreaterThan(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> localIdLessThan(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> localIdBetween(
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

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      presupuestoEstimadoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'presupuestoEstimado',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      presupuestoEstimadoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'presupuestoEstimado',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      presupuestoEstimadoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'presupuestoEstimado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      presupuestoEstimadoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'presupuestoEstimado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      presupuestoEstimadoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'presupuestoEstimado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      presupuestoEstimadoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'presupuestoEstimado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterFilterCondition>
      tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }
}

extension LicitacionQueryObject
    on QueryBuilder<Licitacion, Licitacion, QFilterCondition> {}

extension LicitacionQueryLinks
    on QueryBuilder<Licitacion, Licitacion, QFilterCondition> {}

extension LicitacionQuerySortBy
    on QueryBuilder<Licitacion, Licitacion, QSortBy> {
  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByDiasAnticipacionAlerta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacionAlerta', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByDiasAnticipacionAlertaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacionAlerta', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByEmpresaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByEmpresaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByFechaLimiteEntrega() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaLimiteEntrega', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByFechaLimiteEntregaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaLimiteEntrega', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByFechaPublicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPublicacion', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByFechaPublicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPublicacion', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByPresupuestoEstimado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'presupuestoEstimado', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      sortByPresupuestoEstimadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'presupuestoEstimado', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension LicitacionQuerySortThenBy
    on QueryBuilder<Licitacion, Licitacion, QSortThenBy> {
  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByDiasAnticipacionAlerta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacionAlerta', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByDiasAnticipacionAlertaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diasAnticipacionAlerta', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByEmpresaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByEmpresaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'empresaId', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByFechaLimiteEntrega() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaLimiteEntrega', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByFechaLimiteEntregaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaLimiteEntrega', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByFechaPublicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPublicacion', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByFechaPublicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaPublicacion', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByPresupuestoEstimado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'presupuestoEstimado', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy>
      thenByPresupuestoEstimadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'presupuestoEstimado', Sort.desc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }
}

extension LicitacionQueryWhereDistinct
    on QueryBuilder<Licitacion, Licitacion, QDistinct> {
  QueryBuilder<Licitacion, Licitacion, QDistinct>
      distinctByDiasAnticipacionAlerta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diasAnticipacionAlerta');
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct> distinctByEmpresaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'empresaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct> distinctByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado');
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct>
      distinctByFechaLimiteEntrega() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaLimiteEntrega');
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct> distinctByFechaPublicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaPublicacion');
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct>
      distinctByPresupuestoEstimado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'presupuestoEstimado');
    });
  }

  QueryBuilder<Licitacion, Licitacion, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }
}

extension LicitacionQueryProperty
    on QueryBuilder<Licitacion, Licitacion, QQueryProperty> {
  QueryBuilder<Licitacion, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<Licitacion, int, QQueryOperations>
      diasAnticipacionAlertaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diasAnticipacionAlerta');
    });
  }

  QueryBuilder<Licitacion, String, QQueryOperations> empresaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'empresaId');
    });
  }

  QueryBuilder<Licitacion, EstadoLicitacion, QQueryOperations>
      estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<Licitacion, DateTime, QQueryOperations>
      fechaLimiteEntregaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaLimiteEntrega');
    });
  }

  QueryBuilder<Licitacion, DateTime, QQueryOperations>
      fechaPublicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaPublicacion');
    });
  }

  QueryBuilder<Licitacion, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Licitacion, double?, QQueryOperations>
      presupuestoEstimadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'presupuestoEstimado');
    });
  }

  QueryBuilder<Licitacion, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }
}
