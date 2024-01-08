
import 'package:flutter/material.dart';
import 'package:test_em/module_authorization/authorization_routes.dart';
import 'package:test_em/module_authorization/enums/user_role.dart';
import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';
import 'package:test_em/module_services/services_routes.dart';

class SplashScreen extends StatefulWidget {
  final AuthPrefsHelper _authService;
  // final ProfileService _profileService;

  SplashScreen(
    this._authService,
    // this._profileService,
  );
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) async{
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(child: Text('Emerging Ideas' , style: TextStyle(color: Colors.white,fontSize: 30),),),

    );
  }

  Future<String> _getNextRoute() async {
    try {
     // Is LoggedIn
      bool bol = await widget._authService.isSignedIn();
      print('++++++++++++++++++++ Splash$bol');
      if(bol ){

        return ServiceRoutes.SERVICES_SCREEN;
      }

      // Is Not LoggedInt
     else {
         return AuthorizationRoutes.LOGIN_SCREEN;
      }
    } catch (e) {
              return AuthorizationRoutes.LOGIN_SCREEN;
    }
  }
}


