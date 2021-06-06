import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../../../src/utils/serializers.dart';

part 'error_type.g.dart';

class ErrorType extends EnumClass {
  static const ErrorType noInternet = _$noInternet;
  static const ErrorType noData = _$noData;
  static const ErrorType noError = _$noError;
  static const ErrorType seeOther = _$seeOther;
  static const ErrorType sessionExpired = _$sessionExpired;

  const ErrorType._(String name) : super(name);

  static BuiltSet<ErrorType> get values => _$errorTypeValues;
  static ErrorType valueOf(String name) => _$errorTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(ErrorType.serializer, this);
  }

  static ErrorType deserialize(String string) {
    return serializers.deserializeWith(ErrorType.serializer, string);
  }

  static Serializer<ErrorType> get serializer => _$errorTypeSerializer;
}
