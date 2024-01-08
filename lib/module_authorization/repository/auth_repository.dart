import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';

class AuthRepository {

  AuthPrefsHelper authPrefsHelper = AuthPrefsHelper();
  Future<bool> login(String email ,String password)async{
    try{
      authPrefsHelper.setEmail(email);
      await Future.delayed(Duration(seconds: 1));
      return true;
    }catch(e){
      return false;
    }

  }

}