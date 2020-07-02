import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/models/user.dart';
import 'package:flutterfirebase/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object
  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid:user.uid) :null;
  }

  Stream<User> get user{
  return _auth.onAuthStateChanged
  .map(_userFromFirebase);
  }

  Future anonySignin() async{
    try{
    AuthResult result =await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebase(user);
    }
    catch(e){
      print('error:${e.toString()}');
      return null;
    }
  }
  Future signInEmailPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email,password:password);
      FirebaseUser  user= result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerEmailPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email,password:password);
      FirebaseUser  user= result.user;
      await DatabaseService(uid:user.uid).updateuserData('0', 'crew member', 100);
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
  }
}
}
