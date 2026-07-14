// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresa.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmpresaCollection on Isar {
  IsarCollection<Empresa> get empresas => this.collection();
}

const EmpresaSchema = CollectionSchema(
  name: r'Empresa',
  id: 6619396595510192979,
  properties: {
    r'contactos': PropertySchema(
      id: 0,
      name: r'contactos',
      type: IsarType.objectList,
      target: r'Contacto',
    ),
    r'estadoRelacion': PropertySchema(
      id: 1,
      name: r'estadoRelacion',
      type: IsarType.byte,
      enumMap: _EmpresaestadoRelacionEnumValueMap,
    ),
    r'fechaRegistro': PropertySchema(
      id: 2,
      name: r'fechaRegistro',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 4,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'notasVisita': PropertySchema(
      id: 5,
      name: r'notasVisita',
      type: IsarType.string,
    ),
    r'razonSocial': PropertySchema(
      id: 6,
      name: r'razonSocial',
      type: IsarType.string,
    ),
    r'rubro': PropertySchema(
      id: 7,
      name: r'rubro',
      type: IsarType.string,
    ),
    r'rut': PropertySchema(
      id: 8,
      name: r'rut',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _empresaEstimateSize,
  serialize: _empresaSerialize,
  deserialize: _empresaDeserialize,
  deserializeProp: _empresaDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {r'Contacto': ContactoSchema},
  getId: _empresaGetId,
  getLinks: _empresaGetLinks,
  attach: _empresaAttach,
  version: '3.1.0+1',
);

int _empresaEstimateSize(
  Empresa object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contactos.length * 3;
  {
    final offsets = allOffsets[Contacto]!;
    for (var i = 0; i < object.contactos.length; i++) {
      final value = object.contactos[i];
      bytesCount += ContactoSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.notasVisita.length * 3;
  bytesCount += 3 + object.razonSocial.length * 3;
  bytesCount += 3 + object.rubro.length * 3;
  bytesCount += 3 + object.rut.length * 3;
  return bytesCount;
}

void _empresaSerialize(
  Empresa object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Contacto>(
    offsets[0],
    allOffsets,
    ContactoSchema.serialize,
    object.contactos,
  );
  writer.writeByte(offsets[1], object.estadoRelacion.index);
  writer.writeDateTime(offsets[2], object.fechaRegistro);
  writer.writeString(offsets[3], object.id);
  writer.writeBool(offsets[4], object.isSynced);
  writer.writeString(offsets[5], object.notasVisita);
  writer.writeString(offsets[6], object.razonSocial);
  writer.writeString(offsets[7], object.rubro);
  writer.writeString(offsets[8], object.rut);
  writer.writeDateTime(offsets[9], object.updatedAt);
}

Empresa _empresaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Empresa(
    contactos: reader.readObjectList<Contacto>(
          offsets[0],
          ContactoSchema.deserialize,
          allOffsets,
          Contacto(),
        ) ??
        const [],
    estadoRelacion:
        _EmpresaestadoRelacionValueEnumMap[reader.readByteOrNull(offsets[1])] ??
            EstadoRelacion.prospecto,
    fechaRegistro: reader.readDateTime(offsets[2]),
    id: reader.readString(offsets[3]),
    isSynced: reader.readBoolOrNull(offsets[4]) ?? false,
    localId: id,
    notasVisita: reader.readStringOrNull(offsets[5]) ?? '',
    razonSocial: reader.readString(offsets[6]),
    rubro: reader.readString(offsets[7]),
    rut: reader.readString(offsets[8]),
    updatedAt: reader.readDateTime(offsets[9]),
  );
  return object;
}

P _empresaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Contacto>(
            offset,
            ContactoSchema.deserialize,
            allOffsets,
            Contacto(),
          ) ??
          const []) as P;
    case 1:
      return (_EmpresaestadoRelacionValueEnumMap[
              reader.readByteOrNull(offset)] ??
          EstadoRelacion.prospecto) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EmpresaestadoRelacionEnumValueMap = {
  'prospecto': 0,
  'asesorado': 1,
  'enLicitacion': 2,
  'clienteActivo': 3,
};
const _EmpresaestadoRelacionValueEnumMap = {
  0: EstadoRelacion.prospecto,
  1: EstadoRelacion.asesorado,
  2: EstadoRelacion.enLicitacion,
  3: EstadoRelacion.clienteActivo,
};

Id _empresaGetId(Empresa object) {
  return object.localId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _empresaGetLinks(Empresa object) {
  return [];
}

void _empresaAttach(IsarCollection<dynamic> col, Id id, Empresa object) {
  object.localId = id;
}

extension EmpresaByIndex on IsarCollection<Empresa> {
  Future<Empresa?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  Empresa? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<Empresa?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<Empresa?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(Empresa object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(Empresa object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<Empresa> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<Empresa> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension EmpresaQueryWhereSort on QueryBuilder<Empresa, Empresa, QWhere> {
  QueryBuilder<Empresa, Empresa, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmpresaQueryWhere on QueryBuilder<Empresa, Empresa, QWhereClause> {
  QueryBuilder<Empresa, Empresa, QAfterWhereClause> localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> localIdNotEqualTo(
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

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> localIdGreaterThan(
      Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> localIdLessThan(Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> localIdBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterWhereClause> idNotEqualTo(String id) {
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
}

extension EmpresaQueryFilter
    on QueryBuilder<Empresa, Empresa, QFilterCondition> {
  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> contactosLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> contactosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> contactosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> contactosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
      contactosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> contactosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contactos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> estadoRelacionEqualTo(
      EstadoRelacion value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estadoRelacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
      estadoRelacionGreaterThan(
    EstadoRelacion value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estadoRelacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> estadoRelacionLessThan(
    EstadoRelacion value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estadoRelacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> estadoRelacionBetween(
    EstadoRelacion lower,
    EstadoRelacion upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estadoRelacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> fechaRegistroEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaRegistro',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
      fechaRegistroGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> fechaRegistroLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> fechaRegistroBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idMatches(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> localIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> localIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localId',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> localIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> localIdGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> localIdLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> localIdBetween(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notasVisita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notasVisita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notasVisita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notasVisita',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notasVisita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notasVisita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notasVisita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notasVisita',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> notasVisitaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notasVisita',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
      notasVisitaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notasVisita',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'razonSocial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'razonSocial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'razonSocial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'razonSocial',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'razonSocial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'razonSocial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'razonSocial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'razonSocial',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> razonSocialIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'razonSocial',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition>
      razonSocialIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'razonSocial',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rubro',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rubro',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rubro',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rubro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rubro',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rubro',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rubro',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rubro',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rubro',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rubroIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rubro',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rut',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rut',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rut',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> rutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rut',
        value: '',
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> updatedAtBetween(
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

extension EmpresaQueryObject
    on QueryBuilder<Empresa, Empresa, QFilterCondition> {
  QueryBuilder<Empresa, Empresa, QAfterFilterCondition> contactosElement(
      FilterQuery<Contacto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'contactos');
    });
  }
}

extension EmpresaQueryLinks
    on QueryBuilder<Empresa, Empresa, QFilterCondition> {}

extension EmpresaQuerySortBy on QueryBuilder<Empresa, Empresa, QSortBy> {
  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByEstadoRelacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoRelacion', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByEstadoRelacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoRelacion', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByNotasVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notasVisita', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByNotasVisitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notasVisita', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByRazonSocial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'razonSocial', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByRazonSocialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'razonSocial', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByRubro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rubro', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByRubroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rubro', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByRut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rut', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByRutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rut', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmpresaQuerySortThenBy
    on QueryBuilder<Empresa, Empresa, QSortThenBy> {
  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByEstadoRelacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoRelacion', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByEstadoRelacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoRelacion', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByFechaRegistroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaRegistro', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByNotasVisita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notasVisita', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByNotasVisitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notasVisita', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByRazonSocial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'razonSocial', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByRazonSocialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'razonSocial', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByRubro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rubro', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByRubroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rubro', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByRut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rut', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByRutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rut', Sort.desc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Empresa, Empresa, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmpresaQueryWhereDistinct
    on QueryBuilder<Empresa, Empresa, QDistinct> {
  QueryBuilder<Empresa, Empresa, QDistinct> distinctByEstadoRelacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estadoRelacion');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByFechaRegistro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaRegistro');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByNotasVisita(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notasVisita', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByRazonSocial(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'razonSocial', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByRubro(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rubro', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByRut(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rut', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Empresa, Empresa, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension EmpresaQueryProperty
    on QueryBuilder<Empresa, Empresa, QQueryProperty> {
  QueryBuilder<Empresa, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<Empresa, List<Contacto>, QQueryOperations> contactosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactos');
    });
  }

  QueryBuilder<Empresa, EstadoRelacion, QQueryOperations>
      estadoRelacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estadoRelacion');
    });
  }

  QueryBuilder<Empresa, DateTime, QQueryOperations> fechaRegistroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaRegistro');
    });
  }

  QueryBuilder<Empresa, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Empresa, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<Empresa, String, QQueryOperations> notasVisitaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notasVisita');
    });
  }

  QueryBuilder<Empresa, String, QQueryOperations> razonSocialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'razonSocial');
    });
  }

  QueryBuilder<Empresa, String, QQueryOperations> rubroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rubro');
    });
  }

  QueryBuilder<Empresa, String, QQueryOperations> rutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rut');
    });
  }

  QueryBuilder<Empresa, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
