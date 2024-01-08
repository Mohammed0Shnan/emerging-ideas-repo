import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';

class IsLogginCubit extends Cubit<IsLogginCubitState> {
  AuthPrefsHelper _authService = AuthPrefsHelper();
  IsLogginCubit() : super(IsLogginCubitState.NotLoggedIn){
    _authService.isSignedIn().then((value) {
      if(value)
        emitLoginState();
      else
        emitNotLoginState();

    });
  }
  emitLoginState()=> emit(IsLogginCubitState.LoggedIn);
  emitNotLoginState()=> emit(IsLogginCubitState.NotLoggedIn);

}

enum IsLogginCubitState { LoggedIn, NotLoggedIn }
