// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ErrorType _$noInternet = const ErrorType._('noInternet');
const ErrorType _$noData = const ErrorType._('noData');
const ErrorType _$noError = const ErrorType._('noError');
const ErrorType _$seeOther = const ErrorType._('seeOther');
const ErrorType _$sessionExpired = const ErrorType._('sessionExpired');

ErrorType _$errorTypeValueOf(String name) {
  switch (name) {
    case 'noInternet':
      return _$noInternet;
    case 'noData':
      return _$noData;
    case 'noError':
      return _$noError;
    case 'seeOther':
      return _$seeOther;
    case 'sessionExpired':
      return _$sessionExpired;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ErrorType> _$errorTypeValues =
    new BuiltSet<ErrorType>(const <ErrorType>[
  _$noInternet,
  _$noData,
  _$noError,
  _$seeOther,
  _$sessionExpired,
]);

Serializer<ErrorType> _$errorTypeSerializer = new _$ErrorTypeSerializer();

class _$ErrorTypeSerializer implements PrimitiveSerializer<ErrorType> {
  @override
  final Iterable<Type> types = const <Type>[ErrorType];
  @override
  final String wireName = 'ErrorType';

  @override
  Object serialize(Serializers serializers, ErrorType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ErrorType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ErrorType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
