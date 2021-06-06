// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserModel> _$userModelSerializer = new _$UserModelSerializer();

class _$UserModelSerializer implements StructuredSerializer<UserModel> {
  @override
  final Iterable<Type> types = const [UserModel, _$UserModel];
  @override
  final String wireName = 'UserModel';

  @override
  Iterable<Object> serialize(Serializers serializers, UserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'logged',
      serializers.serialize(object.logged, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  UserModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'logged':
          result.logged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$UserModel extends UserModel {
  @override
  final String user;
  @override
  final String password;
  @override
  final bool logged;

  factory _$UserModel([void Function(UserModelBuilder) updates]) =>
      (new UserModelBuilder()..update(updates)).build();

  _$UserModel._({this.user, this.password, this.logged}) : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('UserModel', 'user');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('UserModel', 'password');
    }
    if (logged == null) {
      throw new BuiltValueNullFieldError('UserModel', 'logged');
    }
  }

  @override
  UserModel rebuild(void Function(UserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        user == other.user &&
        password == other.password &&
        logged == other.logged;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, user.hashCode), password.hashCode), logged.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserModel')
          ..add('user', user)
          ..add('password', password)
          ..add('logged', logged))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel _$v;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  bool _logged;
  bool get logged => _$this._logged;
  set logged(bool logged) => _$this._logged = logged;

  UserModelBuilder();

  UserModelBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user;
      _password = _$v.password;
      _logged = _$v.logged;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserModel;
  }

  @override
  void update(void Function(UserModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserModel build() {
    final _$result = _$v ??
        new _$UserModel._(user: user, password: password, logged: logged);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
