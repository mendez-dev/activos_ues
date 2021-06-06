import 'package:activos/src/models/user/user_model.dart';
import 'package:activos/src/repositories/auth/auth_repository.dart';
import 'package:activos/src/repositories/preferences/preferences_repository.dart';
import 'package:activos/src/utils/const.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._preferencesRepository);

  final PreferencesRepository _preferencesRepository;

  @override
  Future<UserModel> login({String user, String password}) async {
    /// Funcion que verifica si el usuario o contraseña coincide con los
    /// almacenados en la base de datos

    // Tratamos de leer la informacion del local storage
    String storeUser = await _preferencesRepository.getString("user");
    String storePassword = await _preferencesRepository.getString("password");

    storeUser = storeUser != "" ? storeUser : defaultUser;
    storePassword = storePassword != "" ? storePassword : defaultPassword;

    // Verificamos si los datos coinciden con los almacenados en local storage
    if (storeUser == user && storePassword == password) {
      // Guardamos logged true
      await _preferencesRepository.save<bool>("logged", true);

      return UserModel((b) => b
        ..user = storeUser
        ..password = storePassword
        ..logged = true);
    } else {
      return UserModel((b) => b
        ..user = ""
        ..password = ""
        ..logged = false);
    }
  }
}
