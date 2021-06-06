import 'package:activos/src/blocs/auth/auth_bloc.dart';
import 'package:activos/src/blocs/home/home_bloc.dart';
import 'package:activos/src/presentation/pages/develop/develop_page.dart';
import 'package:activos/src/presentation/pages/home/home_page.dart';
import 'package:activos/src/presentation/pages/login/login_page.dart';
import 'package:activos/src/repositories/auth/auth_repository.dart';
import 'package:activos/src/repositories/preferences/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/auth/auth_repository_impl.dart';

class MyApp extends StatelessWidget {
  /// Crea una instancia de nuestra aplicacion recibe como parametro
  /// [logged] que indica si ya se inicio sesion y [preferencesRepository]
  /// una instancia del preferencesRepository creada en el main
  const MyApp({Key key, this.logged = false, this.preferencesRepository})
      : super(key: key);

  /// Variable que indica si el usuario esta logeado o no
  final bool logged;

  /// Instancia del preferencesRepository creada en el main
  final PreferencesRepository preferencesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<PreferencesRepository>.value(
              value: preferencesRepository),
          RepositoryProvider<AuthRepository>(
              create: (BuildContext context) => AuthRepositoryImpl(
                  RepositoryProvider.of<PreferencesRepository>(context))),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                  create: (BuildContext context) => AuthBloc(
                      preferencesRepository:
                          RepositoryProvider.of<PreferencesRepository>(context),
                      authRepository:
                          RepositoryProvider.of<AuthRepository>(context))),
              BlocProvider<HomeBloc>(
                  create: (BuildContext context) => HomeBloc(
                      preferencesRepository:
                          RepositoryProvider.of<PreferencesRepository>(
                              context)))
            ],
            child: MaterialApp(
              theme: ThemeData(primaryColor: Colors.red),
              title: 'Material App',
              home: logged ? HomePage() : LoginPage(),
              routes: {
                "login": (BuildContext context) => LoginPage(),
                "home": (BuildContext context) => HomePage(),
                "develop": (BuildContext context) => DevelopPage()
              },
            )));
  }
}
