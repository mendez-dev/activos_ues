import 'package:activos/src/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_model.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  String get user;
  String get password;
  bool get logged;

  UserModel._();
  factory UserModel([void Function(UserModelBuilder) updates]) = _$UserModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserModel.serializer, this);
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserModel.serializer, json);
  }

  static Serializer<UserModel> get serializer => _$userModelSerializer;
}
