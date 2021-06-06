import 'package:activos/src/blocs/auth/auth_bloc.dart';
import 'package:activos/src/models/errors/error_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/login_header.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _user = TextEditingController();

  final TextEditingController _password = TextEditingController();

  AuthBloc _authBloc;

  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(SingOutEvent());

    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(ClearAuthEvent());

    // Seleccionamos la primer sucursal por defecto
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginHeader(),
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _user,
                        validator: (String value) => (value.trim().length >= 1)
                            ? null
                            : "Ingrese un nombre de usuario",
                        decoration: InputDecoration(labelText: "Usuario"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (String value) => (value.trim().length >= 1)
                            ? null
                            : "Ingrese una contraseña",
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Contraseña"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Theme.of(context).primaryColor),
                    child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (BuildContext context, AuthState state) {
                      if (state.error == ErrorType.noData) {
                        Fluttertoast.showToast(
                            msg: "Usuario o contraseña incorrecta");
                      }
                      if (state.error == ErrorType.noInternet) {
                        Fluttertoast.showToast(
                            msg: "Error al conectar con el servidor");
                      }

                      if (state.loginSucces) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      }
                    }, builder: (BuildContext context, AuthState state) {
                      if (state.loading) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.white)),
                        );
                      }

                      return FlatButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "INICIAR SESION",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        onPressed: () {
                          // * Descomentar para desactivar el login
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, '/home', (route) => false);
                          if (!_formKey.currentState.validate()) return;
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            user: _user.text,
                            password: _password.text,
                          ));
                        },
                      );
                    }))),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
