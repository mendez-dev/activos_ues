import 'package:activos/src/blocs/auth/auth_bloc.dart';
import 'package:activos/src/blocs/home/home_bloc.dart';
import 'package:activos/src/helpers/helpers.dart';
import 'package:activos/src/repositories/preferences/preferences_repository.dart';
import 'package:activos/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  PageController pageController = PageController();

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
        body: PageView(
          controller: pageController,
          children: [
            WebviewScaffold(
              appCacheEnabled: true,
              primary: false,
              url: "http://activo.solucionesideales.com/app/viewSearch.php",
              appBar: new AppBar(
                centerTitle: true,
                title: new Text("ACTIVOS UES"),
              ),
            ),
            ProfileWidget()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuario")
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("PERFIL DE USUARIO"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 35,
                        child: Icon(FontAwesomeIcons.user,
                            size: 30, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(BlocProvider.of<HomeBloc>(context)
                          .state
                          .user
                          .toUpperCase()),
                      Divider(),
                      ListTile(
                        onTap: () => _updateUserInfo(context),
                        leading: Icon(
                          FontAwesomeIcons.userEdit,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text("Editar perfil"),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () => Navigator.pushNamed(context, "develop"),
                        leading: Icon(
                          FontAwesomeIcons.code,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text("Desarrolladores"),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateUserInfo(BuildContext context) async {
    TextEditingController userController = TextEditingController(
        text: BlocProvider.of<HomeBloc>(context).state.user);
    TextEditingController passwordController = TextEditingController();
    String password =
        await RepositoryProvider.of<PreferencesRepository>(context)
            .getString("password");
    password = password != "" ? password : defaultPassword;

    passwordController.text = password;

    GlobalKey<FormState> _form = GlobalKey<FormState>();
    Alert(
        context: context,
        title: "ACTUALIZAR NOMBRE DE USUARIO",
        content: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: userController,
                decoration: InputDecoration(labelText: "Nombre de usuario"),
                validator: (String value) {
                  if (value.length < 3) {
                    return "Ingrese al menos 3 caracteres";
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(labelText: "Nueva contraseña"),
                validator: (String value) {
                  if (value.length < 6) {
                    return "Ingrese al menos 6 caracteres";
                  }
                  return null;
                },
              )
            ],
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
                // Actualizamos informacion
                RepositoryProvider.of<PreferencesRepository>(context)
                    .save<String>("user", userController.text);
                RepositoryProvider.of<PreferencesRepository>(context)
                    .save<String>("password", passwordController.text);

                BlocProvider.of<HomeBloc>(context).add(GetUserNameEvent());
                Navigator.pop(context);
                await Future.delayed(Duration(microseconds: 500));
                await _showSuccesDialog(context);
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
