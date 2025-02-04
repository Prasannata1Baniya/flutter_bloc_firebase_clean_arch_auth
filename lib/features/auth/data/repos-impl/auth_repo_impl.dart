import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_firebase/features/auth/data/model/user_model.dart';
import 'package:flutter_bloc_firebase/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  AuthRepoImpl(this._firebaseAuth,this._firestore);

  @override
  Future<UserModel?> login(String email, String password) async{
    try{
      UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      if(userCredential.user !=null){
        DocumentSnapshot doc=await _firestore.collection('users')
            .doc(userCredential.user!.uid).get();
        if(doc.exists){
          return UserModel.fromJson(doc.data() as Map<String,dynamic>);
        }
        else {
          // If user doesn't exist in Firestore, return a new UserModel with Firebase data
          return UserModel(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: email,
          );
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<UserModel?> register(String name, String email, String password) async{
    try{
      UserCredential userCredential=await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if(userCredential.user!=null) {
        UserModel user = UserModel(
            uid: userCredential.user!.uid,
            name: name,
            email: email,
        );

        //save the users to firebase
        await _firestore.collection("users").doc(user.uid).set(user.toJson());
        return user;
      }
    }catch(e){
      debugPrint(e.toString());
    }
    return null;
}

  @override
  Future<UserModel?> checkCurrentUser() async{
    User? user= _firebaseAuth.currentUser;
    if(user!=null) {
      DocumentSnapshot doc=await _firestore.collection('users').doc(user.uid).get();
      if(doc.exists){
         return UserModel.fromJson(doc.data() as Map<String,dynamic>);
      }else {
        return UserModel.fromJson({
          'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
        });
      }
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    try{
     await _firebaseAuth.signOut();
    }catch(e){
      debugPrint(e.toString());
    }
  }

}