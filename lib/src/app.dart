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
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      title: 'Material App',
      home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<PreferencesRepository>.value(
                value: preferencesRepository),
            RepositoryProvider<AuthRepository>(
                create: (BuildContext context) => AuthRepositoryImpl(
                    RepositoryProvider.of<PreferencesRepository>(context)))
          ],
          child: MultiBlocProvider(
              providers: [],
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Material App Bar'),
                ),
                body: Center(
                  child: Container(
                    child: Text('Hello World'),
                  ),
                ),
              ))),
    );
  }
}
