import 'package:activos/src/blocs/auth/auth_bloc.dart';
import 'package:activos/src/blocs/home/home_bloc.dart';
import 'package:activos/src/helpers/helpers.dart';
import 'package:activos/src/repositories/preferences/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetUserNameEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Helpers.of(context).onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("ACTIVOS UES"),
        ),
        drawer: DrawerWidget(),
        body: WebView(
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://google.com',
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: Icon(
                          FontAwesomeIcons.user,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return Text(
                            state.user.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          );
                        },
                      )
                    ],
                  ),
                )),
            ListTile(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, "home", (route) => false),
              leading: Icon(
                FontAwesomeIcons.home,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Inicio"),
            ),
            Divider(),
            ListTile(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, "develop", (route) => false),
              leading: Icon(
                FontAwesomeIcons.code,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Desarrolladores"),
            ),
            Divider(),
            ListTile(
              onTap: () => _updateUserName(context),
              leading: Icon(
                FontAwesomeIcons.userEdit,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Actualizar nombre de usuario"),
            ),
            Divider(),
            ListTile(
              onTap: () => _updatePassword(context),
              leading: Icon(
                FontAwesomeIcons.key,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Actualizar contraseña"),
            ),
            Divider(),
            ListTile(
              onTap: () => _logout(context),
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserName(BuildContext context) async {
    TextEditingController userController = TextEditingController(
        text: BlocProvider.of<HomeBloc>(context).state.user);
    GlobalKey<FormState> _form = GlobalKey<FormState>();
    Alert(
        context: context,
        title: "ACTUALIZAR NOMBRE DE USUARIO",
        content: Form(
          key: _form,
          child: TextFormField(
            controller: userController,
            decoration: InputDecoration(labelText: "Nombre de usuario"),
            validator: (String value) {
              if (value.length < 3) {
                return "Ingrese al menos 3 caracteres";
              }
              return null;
            },
          ),
        ),
        buttons: [
          DialogButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "ACTUALIZAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (!_form.currentState.validate()) return;
                RepositoryProvider.of<PreferencesRepository>(context)
                    .save<String>("user", userController.text);
                BlocProvider.of<HomeBloc>(context).add(GetUserNameEvent());
                Navigator.pop(context);
                await Future.delayed(Duration(microseconds: 500));
                await _showSuccesDialog(context);
                Navigator.pop(context);
              })
        ]).show();
  }

  void _updatePassword(BuildContext context) async {
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> _form = GlobalKey<FormState>();
    Alert(
        context: context,
        title: "ACTUALIZAR CONTRASEÑA",
        content: Form(
          key: _form,
          child: TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: "Nueva contraseña"),
            validator: (String value) {
              if (value.length < 6) {
                return "Ingrese al menos 6 caracteres";
              }
              return null;
            },
          ),
        ),
        buttons: [
          DialogButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "ACTUALIZAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (!_form.currentState.validate()) return;
                RepositoryProvider.of<PreferencesRepository>(context)
                    .save<String>("password", passwordController.text);
                BlocProvider.of<HomeBloc>(context).add(GetUserNameEvent());
                Navigator.pop(context);
                await Future.delayed(Duration(microseconds: 500));
                await _showSuccesDialog(context);
                Navigator.pop(context);
              })
        ]).show();
  }

  void _logout(BuildContext context) async {
    bool result = false;

    result = await Alert(
        onWillPopActive: true,
        closeFunction: () => Navigator.pop(context, false),
        context: context,
        type: AlertType.info,
        title: "¿Decea cerrar sesión?",
        buttons: [
          DialogButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "NO",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context, false)),
          DialogButton(
              color: Theme.of(context).primaryColor,
              child: Text("SI", style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context, true))
        ]).show();

    if (result) {
      BlocProvider.of<AuthBloc>(context).add(SingOutEvent());
      Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
    }
  }

  Future<void> _showSuccesDialog(BuildContext context) async {
    await Alert(
            context: context,
            title: "Datos actualizados exitosamente",
            buttons: [
              DialogButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "ACEPTAR",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.pop(context))
            ],
            type: AlertType.success)
        .show();
  }
}
