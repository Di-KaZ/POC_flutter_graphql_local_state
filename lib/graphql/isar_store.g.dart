// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_store.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGraphqlLookupCollection on Isar {
  IsarCollection<GraphqlLookup> get graphqlLookups => this.collection();
}

const GraphqlLookupSchema = CollectionSchema(
  name: r'GraphqlLookup',
  id: 133655714682616079,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'isarData': PropertySchema(
      id: 1,
      name: r'isarData',
      type: IsarType.string,
    )
  },
  estimateSize: _graphqlLookupEstimateSize,
  serialize: _graphqlLookupSerialize,
  deserialize: _graphqlLookupDeserialize,
  deserializeProp: _graphqlLookupDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _graphqlLookupGetId,
  getLinks: _graphqlLookupGetLinks,
  attach: _graphqlLookupAttach,
  version: '3.1.0+1',
);

int _graphqlLookupEstimateSize(
  GraphqlLookup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.isarData.length * 3;
  return bytesCount;
}

void _graphqlLookupSerialize(
  GraphqlLookup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeString(offsets[1], object.isarData);
}

GraphqlLookup _graphqlLookupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GraphqlLookup();
  object.id = reader.readStringOrNull(offsets[0]);
  object.isarData = reader.readString(offsets[1]);
  return object;
}

P _graphqlLookupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _graphqlLookupGetId(GraphqlLookup object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _graphqlLookupGetLinks(GraphqlLookup object) {
  return [];
}

void _graphqlLookupAttach(
    IsarCollection<dynamic> col, Id id, GraphqlLookup object) {}

extension GraphqlLookupQueryWhereSort
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QWhere> {
  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GraphqlLookupQueryWhere
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QWhereClause> {
  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GraphqlLookupQueryFilter
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QFilterCondition> {
  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idEqualTo(
    String? value, {
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      idGreaterThan(
    String? value, {
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idLessThan(
    String? value, {
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idContains(
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition> idMatches(
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

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'isarData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'isarData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'isarData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'isarData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarData',
        value: '',
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'isarData',
        value: '',
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GraphqlLookupQueryObject
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QFilterCondition> {}

extension GraphqlLookupQueryLinks
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QFilterCondition> {}

extension GraphqlLookupQuerySortBy
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QSortBy> {
  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> sortByIsarData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarData', Sort.asc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy>
      sortByIsarDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarData', Sort.desc);
    });
  }
}

extension GraphqlLookupQuerySortThenBy
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QSortThenBy> {
  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> thenByIsarData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarData', Sort.asc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy>
      thenByIsarDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarData', Sort.desc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension GraphqlLookupQueryWhereDistinct
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QDistinct> {
  QueryBuilder<GraphqlLookup, GraphqlLookup, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GraphqlLookup, GraphqlLookup, QDistinct> distinctByIsarData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isarData', caseSensitive: caseSensitive);
    });
  }
}

extension GraphqlLookupQueryProperty
    on QueryBuilder<GraphqlLookup, GraphqlLookup, QQueryProperty> {
  QueryBuilder<GraphqlLookup, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<GraphqlLookup, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GraphqlLookup, String, QQueryOperations> isarDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarData');
    });
  }
}
