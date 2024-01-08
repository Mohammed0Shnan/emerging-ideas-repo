
import 'package:flutter/material.dart';
import 'package:test_em/abstracts/module/my_module.dart';
import 'package:test_em/module_services/services_routes.dart';
import 'package:test_em/module_services/ui/screens/service_create.dart';
import 'package:test_em/module_services/ui/screens/service_details.dart';
import 'package:test_em/module_services/ui/screens/services_screen.dart';

class ServiceModule extends MyModule {
 final ServicesScreen _servicesScreen;
 final ServiceDetails _serviceDetails;
 final CreateService _createService;
 ServiceModule(this._servicesScreen ,this._serviceDetails,this._createService);
  Map<String, WidgetBuilder> getRoutes() {
    return {
       ServiceRoutes.SERVICES_SCREEN: (context) => _servicesScreen,
      ServiceRoutes.SERVICES_DETAIL: (context) => _serviceDetails,
      ServiceRoutes.SERVICES_CREATE: (context) => _createService,

    };
  }
}
