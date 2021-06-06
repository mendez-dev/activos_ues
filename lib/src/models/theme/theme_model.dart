import 'package:activos/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'theme_model.g.dart';

class ThemeModel extends EnumClass {
  @BuiltValueField(wireName: 'Claro')
  static const ThemeModel light = _$light;
  static const ThemeModel dark = _$dark;

  const ThemeModel._(String name) : super(name);

  static BuiltSet<ThemeModel> get values => _$themeModelValues;
  static ThemeModel valueOf(String name) => _$themeModelValueOf(name);

  String serialize() {
    return serializers.serializeWith(ThemeModel.serializer, this);
  }

  static ThemeModel deserialize(String string) {
    return serializers.deserializeWith(ThemeModel.serializer, string);
  }

  static Serializer<ThemeModel> get serializer => _$themeModelSerializer;
}
