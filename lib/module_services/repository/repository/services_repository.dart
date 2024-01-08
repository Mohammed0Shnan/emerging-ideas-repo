



import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';
import 'package:test_em/module_network/http_client/http_client.dart';
import 'package:test_em/module_services/model/service_request.dart';

class ServiceRepository {

  final ApiClient apiClient = ApiClient();
  final AuthPrefsHelper _prefsHelper = AuthPrefsHelper();
  Future<List<Map<String,dynamic>>?> getAll() async{
    try{
      String? email = await _prefsHelper.getEmail();

      var result =  await apiClient.get('read.php?email=?$email');

      // here for error handing
      if(result ==null){
        return null;
      }
      else{
       return (result as List ).cast<Map<String,dynamic>>()  ;
      }
    }catch(e){
      return null;
    }

  }



  Future<List<Map<String,dynamic>>?> create(ServiceRequest request) async{
    try{
      String? email = await _prefsHelper.getEmail();
      request.email = email!;
      var result =  await apiClient.post('create.php?',request.toCreateJson());
      // here for error handing
      if(result ==null){
        return null;
      }
      else{
        return (result as List ).cast<Map<String,dynamic>>()  ;
      }
    }catch(e){
      print('error on repo $e');
      return null;
    }

  }


  Future<List<Map<String,dynamic>>?> update(ServiceRequest request) async{
    try{
      String? email = await _prefsHelper.getEmail();
      request.email = email!;
      var result =  await apiClient.put('edit.php?',queryParams: request.toJson());
      // here for error handing
      if(result ==null){
        return null;
      }
      else{
        return (result as List ).cast<Map<String,dynamic>>()  ;
      }
    }catch(e){
      print('error on repo $e');
      return null;
    }

  }


  Future<List<Map<String,dynamic>>?> delete(int id) async{
    try{
      String? email = await _prefsHelper.getEmail();

      var result =  await apiClient.delete('delete.php?email=?$email',queryParams:{'id':id.toString()});
      // here for error handing
      if(result ==null){
        return null;
      }
      else{
        print('============================ $result');
        return (result as List ).cast<Map<String,dynamic>>()  ;
      }
    }catch(e){
      print('error on repo $e');
      return null;
    }

  }

}
