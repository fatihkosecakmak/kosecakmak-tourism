

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/data/service/authentication.dart';

abstract class LoginState{

}
class LoginInitial extends LoginState{
}
class LoginLoading extends LoginState{

}
class LoginCompleted extends LoginState{

}
class LoginError extends LoginState{
}
class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitial());

  var authService = AuthenticationService();
  Future<void> login(String mail,String password) async{
    try{
      emit(LoginLoading());
      var login = await authService.login(mail, password);
      if(login == true){
        emit(LoginCompleted());
      }else{
        emit(LoginError());
      }
    }catch(e){
      print(e.toString());
    }
  }
}