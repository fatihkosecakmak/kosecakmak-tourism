



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/data/service/auth_service.dart';

class LoginCubit extends Cubit<void>{
  LoginCubit():super(0);

  var authService = UserService();

  Future<void> login(String email,String password,BuildContext context) async{
    await authService.login(email, password, context);
  }
}