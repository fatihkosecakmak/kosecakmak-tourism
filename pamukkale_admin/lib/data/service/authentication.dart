



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> login(String email,String password) async{
    var collectionUser = FirebaseFirestore.instance.collection("admin");
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    var userId = auth.currentUser!.uid;
    DocumentSnapshot  snapshot = await collectionUser.doc(userId).get();
    if(snapshot.get('stat') == "admin"){
      return true;
    }else{
      signOut();
      return false;
    }
  }

}