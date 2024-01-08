
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_services/model/service_request.dart';
import 'package:test_em/module_services/service/services_service.dart';

class CreateServiceListBloc extends Bloc<CreateServiceListEvent,CreateServiceListStates>{
  final ServicesService service = ServicesService();
  CreateServiceListBloc() : super(CreateServiceListInitState()) {

    on<CreateServiceListEvent>((CreateServiceListEvent event, Emitter<CreateServiceListStates> emit) {
      if (event is CreateServiceListLoadingEvent)
      {
        emit(CreateServiceListLoadingState());

      }
      else if (event is CreateServiceListErrorEvent){
        emit(CreateServiceListErrorState(message: event.message));
      }

      else if (event is CreateServiceListSuccessEvent){
        emit(CreateServiceListSuccessState(message: event.message));
      }
    });
  }


     updateService(ServiceRequest request) {
    this.add(CreateServiceListLoadingEvent());
    service.updateService(request).then((value) {
      if(value == null){
        this.add(CreateServiceListErrorEvent(message: 'Error In Fetch Data !!'));
      }else{
        this.add(CreateServiceListSuccessEvent(message: value));
      }
    });
  }


  createService(ServiceRequest request) {
    this.add(CreateServiceListLoadingEvent());
    service.createService(request).then((value) {
      if(value == null){
        this.add(CreateServiceListErrorEvent(message: 'Error In Fetch Data !!'));
      }else{
        this.add(CreateServiceListSuccessEvent(message: value));
      }
    });
  }



  @override
  Future<void> close() {

    return super.close();
  }
}



abstract class CreateServiceListEvent { }
class CreateServiceListInitEvent  extends CreateServiceListEvent  {}

class CreateServiceListSuccessEvent  extends CreateServiceListEvent  {
  String  message;
  CreateServiceListSuccessEvent({required this.message});
}
class CreateServiceListLoadingEvent  extends CreateServiceListEvent  {}

class CreateServiceListErrorEvent  extends CreateServiceListEvent  {
  String message;
  CreateServiceListErrorEvent({required this.message});
}

class ServiceDeletedErrorEvent  extends CreateServiceListEvent  {
  String message;
  ServiceDeletedErrorEvent({required this.message});
}


class ServiceDeletedSuccessEvent  extends CreateServiceListEvent  {
  String orderID;
  ServiceDeletedSuccessEvent({required this.orderID});
}



abstract class CreateServiceListStates {}

class CreateServiceListInitState extends CreateServiceListStates {}

class CreateServiceListSuccessState extends CreateServiceListStates {

  String? message;
  CreateServiceListSuccessState({required this.message});
}
class CreateServiceListLoadingState extends CreateServiceListStates {}

class CreateServiceListErrorState extends CreateServiceListStates {
  String message;
  CreateServiceListErrorState({required this.message});
}





