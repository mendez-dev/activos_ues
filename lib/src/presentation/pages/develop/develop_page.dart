import 'package:activos/src/helpers/helpers.dart';
import 'package:activos/src/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DevelopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Helpers.of(context).onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("DESARROLLADORES"),
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
