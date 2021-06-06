// import 'package:activos/src/app.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/repositories/preferences/preferences_repository_impl.dart';
import 'src/utils/logger.dart';

void main() async {
  // Variable para verificar si el usuario ya esta logeado por defecto [false]
  bool logged = false;

  // Se llama este metodo cuando se necesita ejecutar codigo antes que
  // se muestre el primer widget, todo se ejecuta en el spalsh screen
  WidgetsFlutterBinding.ensureInitialized();

  // Creamos una instancia del preferencesRepository el cual nos permite
  // acceder al local storage
  final preferencesRepository = PreferencesRepositoryImpl();

  try {
    // Verificamos si el usuario ya esta logeado en el local storage
    logged = await preferencesRepository.getBool("logged");
  } catch (e) {
    logger.e("NO HAY SESION INICIADA");
  }

  // Iniciamos nuestra app
  runApp(MyApp(
    logged: logged,
    preferencesRepository: preferencesRepository,
  ));
}
