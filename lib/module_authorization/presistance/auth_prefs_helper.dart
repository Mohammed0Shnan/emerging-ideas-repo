
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefsHelper {




  Future<void> setEmail(String email) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
     preferencesHelper.setString('email', email);
  }

  Future<String?> getEmail() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('email');
  }


  Future<bool> logout() async{
    try{
      SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
      await preferencesHelper.clear();
      return true;
    }catch(e){
      return false;
    }



  }



   

  Future<bool> isSignedIn() async {
    try {
      String? uid = await getEmail();
      return uid != null;
    } catch (e) {
      return false;
    }
  }

}
