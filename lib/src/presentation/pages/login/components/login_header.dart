import 'package:flutter/material.dart';

import 'login_clipers.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipper2(),
          child: Container(
            child: Column(),
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.red[200], Colors.red[100]])),
          ),
        ),
        ClipPath(
          clipper: WaveClipper3(),
          child: Container(
            child: Column(),
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.red[300], Colors.red[200]])),
          ),
        ),
        ClipPath(
          clipper: WaveClipper1(),
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Container(width: 130, child: Image.asset("assets/logo.png")),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "INICIO DE SESIÓN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 27),
                ),
              ],
            ),
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ])),
          ),
        ),
      ],
    );
  }
}
