import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DevelopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appCacheEnabled: true,
      primary: false,
      url: "http://activo.solucionesideales.com/app/viewDev.php",
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("DESARROLLADORES"),
      ),
    );
  }
}
