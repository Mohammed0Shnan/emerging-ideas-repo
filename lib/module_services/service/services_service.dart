import 'dart:async';

import 'package:test_em/module_services/model/service_model.dart';
import 'package:test_em/module_services/model/service_request.dart';
import 'package:test_em/module_services/repository/repository/services_repository.dart';


class ServicesService {
  final ServiceRepository repository = ServiceRepository();

  Future<List<ServiceModel>?> getServices() async {
    List<Map<String, dynamic>>? res = await repository.getAll();
    print(res);
    try {
      if (res == null) {
        return null;
      }
      // DTO
      else {
        // empity list
        if (res.length == 1 && res[0]['message'] != null) {
          return [];
        } else {
          List<ServiceModel> list = [];
          res.forEach((element) {
            list.add(ServiceModel.fromMap(element));
          });
          return list;
        }
      }
    }
    catch (e) {
      print('eeeeeeeeeeeeeeeeeee$e');
      return null;
    }
  }



  Future<String?> updateService(ServiceRequest  request) async {

    List<Map<String ,dynamic>>? res= await repository.update(  request);
    if(res != null){

      return res[0]['message'];
    }
    return null;

  }

  Future<String?> deleteService(int id) async{
    List<Map<String ,dynamic>>? res= await repository.delete(  id);
    if(res != null){

      return res[0]['message'];
    }
    return null;

  }

  Future<String?> createService(ServiceRequest request) async {
    List<Map<String, dynamic>>? res = await repository.create(request);
    if (res != null) {
      return res[0]['message'];
    }
    return null;
  }
}
