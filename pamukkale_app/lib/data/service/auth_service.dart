
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamukkale_app/ui/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{

  var collectionUser = FirebaseFirestore.instance.collection("users");
  var auth = FirebaseAuth.instance;
  final firestore =FirebaseFirestore.instance;


  Future<void> login(String email,String password,BuildContext context) async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot doc = await collectionUser.doc(auth.currentUser!.uid).get();
      if(doc["is_disabled"] == true){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hesabınız silinmiş. Kurtarmak için bizimle iletişime geçin")));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> registration(BuildContext context,String user_name, String user_surname,String date,String user_gender,String email,String user_phone,String password,String passwordAgain,String user_id) async{
    try{
      if(password == passwordAgain){
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        var newUser = HashMap<String,dynamic>();
        var user_uid = auth.currentUser!.uid;
        newUser["user_name"] = user_name;
        newUser["user_surname"] = user_surname;
        newUser["user_date"] = date;
        newUser["user_gender"] = user_gender;
        newUser["email"] = email;
        newUser["user_phone"] = user_phone;
        newUser["user_password"] = password;
        newUser["user_id"] = user_id;
        newUser["user_uid"] = user_uid;
        collectionUser.add(newUser);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
      }else{
        print("passwords do not match");
      }
    }catch(e){

    }
  }
  Future<bool> signOut(BuildContext context) async{
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
    return false;
  }
  Future<bool> checkUserStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = (preferences.getBool('seen') ?? false);
    var user = auth.currentUser;
    if (seen) {
      return user != null;
    } else {
      await preferences.setBool('seen', true);
      return false;
    }
  }

  Future<void> disableUser(BuildContext context) async {
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.collection('users').doc(user.uid).update({
          'is_disabled': true,
        });
        signOut(context);
      }
  }

}