
import 'package:flutter/material.dart';

import 'package:test_em/abstracts/module/my_module.dart';
import 'package:test_em/module_splash/screen/splash_screen.dart';
import 'package:test_em/module_splash/splash_routes.dart';

class SplashModule extends MyModule {
  
  final SplashScreen _splashScreen;
  SplashModule(this._splashScreen ) ;

  @override
  Map<String, WidgetBuilder> getRoutes() {
  return {SplashRoutes.SPLASH_SCREEN : (context) => _splashScreen};
  }
}