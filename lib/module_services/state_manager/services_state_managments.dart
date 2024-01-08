
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_services/model/service_model.dart';
import 'package:test_em/module_services/service/services_service.dart';

class ServicesListBloc extends Bloc<ServicesListEvent,ServicesListStates>{
  final ServicesService service = ServicesService();
  ServicesListBloc() : super(ServicesListLoadingState()) {

    on<ServicesListEvent>((ServicesListEvent event, Emitter<ServicesListStates> emit) {
      if (event is ServicesListLoadingEvent)
      {
        emit(ServicesListLoadingState());

      }
      else if (event is ServicesListErrorEvent){
        emit(ServicesListErrorState(message: event.message));
      }

      else if (event is ServicesListSuccessEvent){
        emit(ServicesListSuccessState(services: event.services,message: null));
      }
    });
  }



   getServices() {
    this.add(ServicesListLoadingEvent());
    service.getServices().then((value) {
   if(value == null){
     this.add(ServicesListErrorEvent(message: 'Error In Fetch Data !!'));
   }else{
     this.add(ServicesListSuccessEvent(services: value));
   }
    });
  }

  syncronization(int id){
    List<ServiceModel> _list = [];
    ( state as ServicesListSuccessState ).services.forEach((element) {
      if(element.id != id){
        _list.add(element);
      }
    });
    this.add(ServicesListSuccessEvent(services: _list));
  }



  @override
  Future<void> close() {

    return super.close();
  }
}



abstract class ServicesListEvent { }
class ServicesListInitEvent  extends ServicesListEvent  {}

class ServicesListSuccessEvent  extends ServicesListEvent  {
  List<ServiceModel>  services;
  ServicesListSuccessEvent({required this.services});
}
class ServicesListLoadingEvent  extends ServicesListEvent  {}

class ServicesListErrorEvent  extends ServicesListEvent  {
  String message;
  ServicesListErrorEvent({required this.message});
}

class ServiceDeletedErrorEvent  extends ServicesListEvent  {
  String message;
  ServiceDeletedErrorEvent({required this.message});
}


class ServiceDeletedSuccessEvent  extends ServicesListEvent  {
  String orderID;
  ServiceDeletedSuccessEvent({required this.orderID});
}



abstract class ServicesListStates {}

class ServicesListInitState extends ServicesListStates {}

class ServicesListSuccessState extends ServicesListStates {
  List<ServiceModel>  services;

  String? message;
  ServicesListSuccessState({required this.services,required this.message});
}
class ServicesListLoadingState extends ServicesListStates {}

class ServicesListErrorState extends ServicesListStates {
  String message;
  ServicesListErrorState({required this.message});
}





