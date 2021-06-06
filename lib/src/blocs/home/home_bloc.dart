import 'dart:async';

import 'package:activos/src/repositories/preferences/preferences_repository.dart';
import 'package:activos/src/utils/const.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({PreferencesRepository preferencesRepository})
      : this._preferencesRepository = preferencesRepository,
        super(HomeState.initial());

  final PreferencesRepository _preferencesRepository;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetUserNameEvent) {
      yield* _mapGetUserNameEventToState();
    }
  }

  Stream<HomeState> _mapGetUserNameEventToState() async* {
    // Leemos el nombre de usuario del local storage
    String userName = await _preferencesRepository.getString("user");
    if (userName == "") {
      userName = defaultUser;
    }

    yield state.copyWith(user: userName);
  }
}
