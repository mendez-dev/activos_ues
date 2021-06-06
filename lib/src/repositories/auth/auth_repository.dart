import 'package:activos/src/models/user/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({String user, String password});
  void logout();
}
