
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/data/service/auth_service.dart';

class HomeCubit extends Cubit<bool> {
  HomeCubit() : super(false);

  final UserService authRepo = UserService();

  Future<void> userCheckStatus(BuildContext context) async {
    bool isLogin = await authRepo.checkUserStatus();
    emit(isLogin);
  }
  Future<void> signOut(BuildContext context) async{
    bool isLogin = await authRepo.signOut(context);
    emit(isLogin);
  }
}
