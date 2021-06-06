abstract class PreferencesRepository {
  Future<void> save<Type>(String key, Type value);

  Future<void> remove(String key);

  Future<String> getToken();

  Future<String> getBaseUrl();

  Future<double> getDouble(String key);

  Future<bool> getBool(String key);

  Future<String> getString(String key);
}
