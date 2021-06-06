import 'dart:async';

import 'package:activos/src/repositories/auth/auth_repository.dart';

import '../../repositories/preferences/preferences_repository.dart';
import '../../utils/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final PreferencesRepository _preferencesRepository;
  final DataBaseRepository _dataBaseRepository;
  AuthBloc(
      {AuthRepository authRepository,
      PreferencesRepository preferencesRepository,
      DataBaseRepository dataBaseRepository})
      : this._authRepository = authRepository,
        this._preferencesRepository = preferencesRepository,
        this._dataBaseRepository = dataBaseRepository,
        super(AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginEventToState(
          user: event.user, password: event.password, store: event.store);
    } else if (event is SingOutEvent) {
      yield* _mapSingOutEventToState(event);
    } else if (event is GetUserEvent) {
      yield* _mapGetUserEventToState();
    } else if (event is ClearAuthEvent) {
      yield AuthState.initial();
    } else if (event is SetVerifyUserEvent) {
      yield state.copyWith(user: event.user);
    } else if (event is ChangeStoreEvent) {
      _preferencesRepository.save("store", event.store);
      yield state.copyWith(store: event.store);
    }
  }

  /// Obtener la información del usuario
  ///
  /// Lee la informacion de la sucursal y el usuario de las preferencias del
  /// usuario y la base de datos local, respectivamente
  Stream<AuthState> _mapGetUserEventToState() async* {
    yield state.copyWith(loading: true);
    final int store = await _preferencesRepository.getStore();

    final UserModel user = await _dataBaseRepository.getUser();
    if (user != null) {
      yield state.copyWith(store: store, user: user, loading: false);
    } else {
      logger.e("ERROR AL LEER LA BASE DE DATOS");
      _preferencesRepository.remove("token");
      _preferencesRepository.remove("logged");
      _preferencesRepository.remove("store");
      yield state.copyWith(
        loginSucces: false,
        error: ErrorType.sessionExpired,
      );
    }
  }

  /// Cerrar Sesión
  ///
  /// Elimina de las preferencias del usuario el token de acceso
  Stream<AuthState> _mapSingOutEventToState(SingOutEvent event) async* {
    _preferencesRepository.remove("token");
    _preferencesRepository.remove("logged");
    _preferencesRepository.remove("store");
  }

  /// Login
  ///
  /// Envia las credenciales de acceso al servidor y si son correctas retornan
  /// la información del usuario junto a un token de acceso
  Stream<AuthState> _mapLoginEventToState(
      {String user, String password, int store}) async* {
    // Indicamos que esta cargando
    yield state.copyWith(loading: true);

    // Creamos nuestra instancia de login

    LoginModel login = LoginModel((b) => b
      ..user = user
      ..password = password
      ..store = store);

    try {
      final UserResponse response = await _authRepository.login(login);
      logger.v(response);
      if (response.code == 200) {
        logger.i("LOGIN EXITOSO");

        // Guardamos el token, la bandera de login y el id de la sucursal seleccionada
        await _preferencesRepository.save<String>("token", response.data.token);
        await _preferencesRepository.save<bool>("logged", true);
        await _preferencesRepository.save<int>("store", store);

        // Almacenamos en la base de datos local la informacion del usuario
        await _dataBaseRepository.insertUser(user: response.data);

        // Si la respuesta es exitosa actualizamos el estado
        yield state.copyWith(
            loading: false,
            error: ErrorType.noError,
            user: response.data,
            store: store,
            loginSucces: true);
        yield state.copyWith(loginSucces: false);
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT) {
        logger.e("ERROR DE SERVIDOR");
        logger.e(error.type);
        logger.i(error.response);
        yield state.copyWith(error: ErrorType.noInternet, loading: false);
        yield AuthState.initial();
      } else if (error.type == DioErrorType.RESPONSE) {
        yield state.copyWith(error: ErrorType.noData, loading: false);
        logger.e("ERROR DE RESPUESTA");
        logger.e("CODIGO: ${error.response.statusCode}");
        logger.e("MENSAJE: ${error.response.data['message']}");
        yield state.copyWith(error: ErrorType.noError, loading: false);
      }
    }
  }
}
