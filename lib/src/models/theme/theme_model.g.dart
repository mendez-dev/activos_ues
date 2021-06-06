// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ThemeModel _$light = const ThemeModel._('light');
const ThemeModel _$dark = const ThemeModel._('dark');

ThemeModel _$themeModelValueOf(String name) {
  switch (name) {
    case 'light':
      return _$light;
    case 'dark':
      return _$dark;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ThemeModel> _$themeModelValues =
    new BuiltSet<ThemeModel>(const <ThemeModel>[
  _$light,
  _$dark,
]);

Serializer<ThemeModel> _$themeModelSerializer = new _$ThemeModelSerializer();

class _$ThemeModelSerializer implements PrimitiveSerializer<ThemeModel> {
  @override
  final Iterable<Type> types = const <Type>[ThemeModel];
  @override
  final String wireName = 'ThemeModel';

  @override
  Object serialize(Serializers serializers, ThemeModel object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ThemeModel deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ThemeModel.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
