
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_authorization/enums/auth_status.dart';
import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';
import 'package:test_em/module_authorization/repository/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  final AuthRepository _repo = AuthRepository();

  LoginBloc() : super(LoginInitState()) {
    on<LoginEvent>((LoginEvent event, Emitter<LoginStates> emit) {
      if (event is LoginLoadingEvent)
        emit(LoginLoadingState());
      else if (event is LoginErrorEvent){
        emit(LoginErrorState(message: event.message));
      }
      else if (event is LoginSuccessEvent) 
      emit(LoginSuccessState(message: event.message));

      else {
        emit(LoginInitState());
      }
    });
  }


  login(String email, String password) async {
    this.add(LoginLoadingEvent());
    _repo.login(email, password).then((value) {
      if (value) {
        this.add(LoginSuccessEvent(message: 'Success'));
      } else{
        this.add(LoginErrorEvent(message: 'Error'));

      }
    });
  }

  logout(){
    this.add(LoginLoadingEvent());
   AuthPrefsHelper().logout().then((value) {
     print('+++++++++++++++++++++++$value');

     if (value) {
        this.add(LoginSuccessEvent(message: 'Success'));
      } else{
        this.add(LoginErrorEvent(message: 'Error'));

      }
    });
  }

}

abstract class LoginEvent { }
class LoginInitEvent  extends LoginEvent  {}

class LoginSuccessEvent  extends LoginEvent  {
  String message;
  LoginSuccessEvent({required this.message});
}

class LoginLoadingEvent  extends LoginEvent  {}

class LoginErrorEvent  extends LoginEvent  {
  String message;
  LoginErrorEvent({required this.message});
}

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginSuccessState extends LoginStates {
    String message;
  LoginSuccessState({required this.message});
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
    String message;
  LoginErrorState({required this.message});
}
