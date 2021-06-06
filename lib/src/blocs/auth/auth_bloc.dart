import 'dart:async';

import 'package:activos/src/models/errors/error_type.dart';
import 'package:activos/src/models/user/user_model.dart';
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

  AuthBloc(
      {AuthRepository authRepository,
      PreferencesRepository preferencesRepository})
      : this._authRepository = authRepository,
        this._preferencesRepository = preferencesRepository,
        super(AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _mapLoginEventToState(user: event.user, password: event.password);
    } else if (event is SingOutEvent) {
      yield* _mapSingOutEventToState(event);
    } else if (event is ClearAuthEvent) {
      yield AuthState.initial();
    } else if (event is SetVerifyUserEvent) {
      yield state.copyWith(user: event.user);
    } else if (event is ChangeStoreEvent) {
      _preferencesRepository.save("store", event.store);
      yield state.copyWith(store: event.store);
    }
  }

  /// Cerrar Sesión
  ///
  /// Elimina de las preferencias del usuario el token de acceso
  Stream<AuthState> _mapSingOutEventToState(SingOutEvent event) async* {
    _preferencesRepository.remove("token");
    _preferencesRepository.remove("logged");
  }

  /// Login
  ///
  /// Envia las credenciales de acceso al servidor y si son correctas retornan
  /// la información del usuario junto a un token de acceso
  Stream<AuthState> _mapLoginEventToState(
      {String user, String password}) async* {
    // Indicamos que esta cargando
    yield state.copyWith(loading: true);
    await Future.delayed(Duration(milliseconds: 500));

    // Creamos nuestra instancia de login
    try {
      final UserModel userResponse =
          await _authRepository.login(user: user, password: password);

      if (userResponse.logged) {
        logger.i("LOGIN EXITOSO");

        // Guardamos el token, la bandera de login y el id de la sucursal seleccionada
        await _preferencesRepository.save<bool>("logged", true);

        // Si la respuesta es exitosa actualizamos el estado
        yield state.copyWith(
            loading: false,
            error: ErrorType.noError,
            user: userResponse,
            loginSucces: true);
        yield state.copyWith(loginSucces: false);
      } else {
        yield state.copyWith(
            loginSucces: false, error: ErrorType.noData, loading: false);
        yield AuthState.initial();
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
