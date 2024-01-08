



import 'package:test_em/di/components/app.component.dart';
import 'package:test_em/main.dart';
import 'package:test_em/module_authorization/authorization_module.dart';
import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';
import 'package:test_em/module_authorization/screens/login_screen.dart';
import 'package:test_em/module_services/services_module.dart';
import 'package:test_em/module_services/ui/screens/service_create.dart';
import 'package:test_em/module_services/ui/screens/service_details.dart';
import 'package:test_em/module_services/ui/screens/services_screen.dart';
import 'package:test_em/module_splash/screen/splash_screen.dart';
import 'package:test_em/module_splash/splash_module.dart';

class AppComponentInjector implements AppComponent {
  AppComponentInjector._();


  static Future<AppComponent> create() async {
    final injector = AppComponentInjector._();
    return injector;
  }

  MyApp _createApp() => MyApp(_createServicesModule(),_createAuthModule(),_createSplashModule() );

  SplashModule _createSplashModule()=> SplashModule(SplashScreen(AuthPrefsHelper()));
  AuthorizationModule _createAuthModule()=> AuthorizationModule(LoginScreen());
  ServiceModule _createServicesModule() => ServiceModule(
    ServicesScreen(),ServiceDetails(),CreateService()
      );



  MyApp get app {
    return _createApp();
  }
}
