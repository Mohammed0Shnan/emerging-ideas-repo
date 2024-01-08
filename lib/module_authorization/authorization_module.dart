
import 'package:flutter/cupertino.dart';
import 'package:test_em/abstracts/module/my_module.dart';
import 'package:test_em/module_authorization/screens/login_screen.dart';
import 'authorization_routes.dart';

class AuthorizationModule extends MyModule {
   final LoginScreen _loginScreen  ;

   AuthorizationModule(this._loginScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
       AuthorizationRoutes.LOGIN_SCREEN : (context) => _loginScreen,

    };
  }
}
