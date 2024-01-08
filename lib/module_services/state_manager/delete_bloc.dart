
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_services/model/service_request.dart';
import 'package:test_em/module_services/service/services_service.dart';

class DeleteServiceListBloc extends Bloc<DeleteServiceListEvent,DeleteServiceListStates>{
  final ServicesService service = ServicesService();
  DeleteServiceListBloc() : super(DeleteServiceListInitState()) {

    on<DeleteServiceListEvent>((DeleteServiceListEvent event, Emitter<DeleteServiceListStates> emit) {
      if (event is DeleteServiceListLoadingEvent)
      {
        emit(DeleteServiceListLoadingState());

      }
      else if (event is DeleteServiceListErrorEvent){
        emit(DeleteServiceListErrorState(message: event.message));
      }

      else if (event is DeleteServiceListSuccessEvent){
        emit(DeleteServiceListSuccessState(message: event.message,id: event.id));
      }
    });
  }


  deleteService(int id) {
    this.add(DeleteServiceListLoadingEvent());
    service.deleteService(id).then((value) {
      if(value == null){
        this.add(DeleteServiceListErrorEvent(message: 'Error In Fetch Data !!'));
      }else{
        this.add(DeleteServiceListSuccessEvent(message: value,id:id));
      }
    });
  }




  @override
  Future<void> close() {

    return super.close();
  }
}



abstract class DeleteServiceListEvent { }
class DeleteServiceListInitEvent  extends DeleteServiceListEvent  {}

class DeleteServiceListSuccessEvent  extends DeleteServiceListEvent  {
  String  message;
  int id;
  DeleteServiceListSuccessEvent({required this.message ,required this.id});
}
class DeleteServiceListLoadingEvent  extends DeleteServiceListEvent  {}

class DeleteServiceListErrorEvent  extends DeleteServiceListEvent  {
  String message;
  DeleteServiceListErrorEvent({required this.message});
}

class ServiceDeletedErrorEvent  extends DeleteServiceListEvent  {
  String message;
  ServiceDeletedErrorEvent({required this.message});
}


class ServiceDeletedSuccessEvent  extends DeleteServiceListEvent  {
  String orderID;
  ServiceDeletedSuccessEvent({required this.orderID});
}



abstract class DeleteServiceListStates {}

class DeleteServiceListInitState extends DeleteServiceListStates {}

class DeleteServiceListSuccessState extends DeleteServiceListStates {
   int id;
  String? message;
  DeleteServiceListSuccessState({required this.message,required this.id});
}
class DeleteServiceListLoadingState extends DeleteServiceListStates {}

class DeleteServiceListErrorState extends DeleteServiceListStates {
  String message;
  DeleteServiceListErrorState({required this.message});
}





