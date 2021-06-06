part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();
  @override
  List<Object> get props => [];
}

/// {@template login_event}
/// Login
///
/// Al ejecutar el evento login se hace una petición a la correspondiente [API]
/// para obtener la información del usuario, al momento de ejecutar el evento
/// se envian como parametro el [user] que puede ser nombre de usuario o un
/// correo y tambien al [password]
///
///
/// {@endtemplate}
class LoginEvent implements AuthEvent {
  /// {@macro login_event}
  LoginEvent({
    @required this.user,
    @required this.password,
  });

  /// Nombre de usuario
  ///
  /// Puede ser un correo o un nombre de usuario que se haya signado en el
  /// sistema, en caso de que solo se adminta correo se debera modificar el
  /// formulario para que solo admita formatos de correos validos
  final String user;

  /// Contraseña
  ///
  /// Clave de acceso al sistema se recomienda un minimo de 6 caracteres
  final String password;

  @override
  List<Object> get props => [this.user, this.password];

  @override
  bool get stringify => true;
}

/// {@template get_user_event}
/// Obtener informacion del usuario
///
/// Al ejecutar el evento hace una petición a la [API] correspondiente en el
/// endpoint [verify] para obtener la información del usuario
///
///
/// {@endtemplate}
class GetUserEvent implements AuthEvent {
  /// {@macro get_user_event}

  GetUserEvent();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

/// {@template set_verify_user_event}
/// Enviar información del usuario
///
/// Actualiza la información del usuario en el bloc [AuthBloc], envia como
/// parametro el objeto del usuario obtenido al momento de iniciar la
/// aplicación.
///
/// Este evento se debe ejecutar al momento de cargar la app luego de haber
/// obtenido el usuario directamente del [AuthRepository].
///
///
/// {@endtemplate}
class SetVerifyUserEvent implements AuthEvent {
  /// {@macro set_verify_user_event}
  SetVerifyUserEvent({@required this.user});

  /// Usuario
  ///
  /// Contiene la información del usuario obtenida desde el [AuthRepository]
  final UserModel user;
  @override
  List<Object> get props => [this.user];

  @override
  bool get stringify => true;
}

/// {@template sing_out_event}
/// Cerrar sesión
///
/// Elimina de las preferencias del usuario el token de acceso
///
/// {@endtemplate}
class SingOutEvent implements AuthEvent {
  /// {@macro sing_out_event}
  SingOutEvent();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

/// {@template clear_auth_event}
/// Limpiar bloc
///
/// Reinicia el [AuthBloc] a su estado inicial
///
/// {@endtemplate}
class ClearAuthEvent implements AuthEvent {
  /// {@macro clear_auth_event}
  ClearAuthEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

/// {@template change_store_event}
/// Cambiar sucursal seleccionada
///
/// Cambia la sucursal seleccionada para leer los datos que correspondan a dicha
/// sucursal
///
/// {@endtemplate}
class ChangeStoreEvent implements AuthEvent {
  /// {@macro change_store_event}
  ChangeStoreEvent({this.store});

  final int store;

  @override
  List<Object> get props => throw UnimplementedError();

  @override
  bool get stringify => throw UnimplementedError();
}
