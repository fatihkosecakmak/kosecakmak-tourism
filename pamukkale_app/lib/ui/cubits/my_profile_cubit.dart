


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/data/model/user_model.dart';
import 'package:pamukkale_app/data/service/auth_service.dart';

abstract class UserState{

}
class UserInitial extends UserState{
  UserInitial();
}
class UserCompleted extends UserState{
  UserModel user;
  UserCompleted(this.user);
}
class MyProfileCubit extends Cubit<UserState>{
  MyProfileCubit():super(UserInitial());

  var authService = UserService();

  Future<void> deleteAccount(BuildContext context) async{
    await authService.disableUser(context);
  }
  final collectionUser = FirebaseFirestore.instance.collection("users");
  Future<void> getUserInfo() async {
    try {
      var userDocId = FirebaseAuth.instance.currentUser!.uid;
      print(userDocId);
      Future.delayed(Duration(milliseconds: 1000));
      final querySnapshot = await collectionUser.doc(userDocId).get();
      var data = querySnapshot.data();
      var key = querySnapshot.id;
      var user = UserModel.fromJson(data!, key);
      emit(UserCompleted(user));

    } catch (e) {
      print(e);
    }
  }
  Future<void> updateUserInfo(String updatedName,String updatedSurname,String updatedPhone) async{
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    var updateUserInfos = HashMap<String,dynamic>();
    updateUserInfos["user_name"] = updatedName;
    updateUserInfos["user_surname"] = updatedSurname;
    updateUserInfos["user_phone"] = updatedPhone;
    collectionUser.doc(currentUser).update(updateUserInfos);
  }


}