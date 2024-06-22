



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/data/service/auth_service.dart';

class SignUpCubit extends Cubit<void>{
  SignUpCubit():super(0);

  var service = UserService();

  Future<void> registration(BuildContext context,String email, String password, String passwordAgain, String user_gender,String user_name,
      String user_surname, String date, String user_phone, String user_id) async{
     await service.registration(context, user_name, user_surname, date, user_gender, email, user_phone, password, passwordAgain, user_id);
  }
}