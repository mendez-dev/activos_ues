import 'package:activos/src/models/theme/theme_model.dart';
import 'package:activos/src/repositories/preferences/preferences_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:string_validator/string_validator.dart';

class PreferencesRepositoryImpl extends PreferencesRepository {
  final String _tokenKey = "token";
  static const String _themeIndexKey = 'themeIndex';
  final _storage = FlutterSecureStorage();

  @override
  Future<void> remove(String key) async {
    _storage.delete(key: key);
  }

  @override
  Future<void> save<Type>(String key, Type value) async {
    if (value is String) {
      _storage.write(key: key, value: value);
    } else {
      _storage.write(key: key, value: toString(value));
    }
  }

  @override
  Future<String> getToken() async {
    return Future.value(await _storage.read(key: _tokenKey));
  }

  @override
  Future<String> getBaseUrl() async {
    return Future.value(await _storage.read(key: _tokenKey));
  }

  @override
  Future<double> getDouble(String key) async {
    final value = await _storage.read(key: key);
    return Future.value(double.parse(value));
  }

  @override
  Future<bool> getBool(String key) async {
    final value = await _storage.read(key: key);

    if (value != null) {
      return Future.value(toBoolean(value, true));
    }

    return Future.value(false);
  }

  @override
  Future<String> getString(String key) async {
    final String value = await _storage.read(key: key);

    if (value != null) {
      return value;
    }

    return "";
  }

  @override
  Future<ThemeModel> getTheme() async {
    final value = await _storage.read(key: _themeIndexKey);

    if (value != null) {
      return ThemeModel.valueOf(value);
    } else {
      return null;
    }
  }

  @override
  Future<void> setTheme(ThemeModel theme) async {
    _storage.write(key: _themeIndexKey, value: theme.name);
  }
}
