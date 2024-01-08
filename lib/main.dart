import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_em/di/components/app.component.dart';
import 'package:test_em/module_authorization/authorization_module.dart';
import 'package:test_em/module_services/services_module.dart';
import 'package:test_em/module_services/services_routes.dart';
import 'package:test_em/module_splash/splash_module.dart';
import 'package:test_em/module_splash/splash_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// di
  final container = await AppComponent.create();

  /// Your App Is Here ...
  runApp(
    container.app,
  );

}

class MyApp extends StatefulWidget {

  final ServiceModule _serviceModule;
  final AuthorizationModule _authorizationModule;
  final SplashModule _splashModule;
  MyApp(this._serviceModule,this._authorizationModule,this._splashModule

      );

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {};
    routes.addAll(widget._serviceModule.getRoutes());
    routes.addAll(widget._authorizationModule.getRoutes());
    routes.addAll(widget._splashModule.getRoutes());
    return FutureBuilder<Widget>(
      initialData: Container(color: Colors.green),
      future: configuratedApp(routes),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        return snapshot.data!;
      },
    );
  }

  Future<Widget> configuratedApp(
      Map<String, WidgetBuilder> routes,
      ) async {
    return MaterialApp(




      debugShowCheckedModeBanner: false,
      title: 'Emerging Ideas Test',
      routes: routes,
      initialRoute:SplashRoutes.SPLASH_SCREEN,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
