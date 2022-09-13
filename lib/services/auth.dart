import 'package:blood_donation/screens/add_info_screen.dart';
import 'package:blood_donation/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';
import '../Utils/utils.dart';
import '../main.dart';
import '../models/users.dart';
import 'database.dart';

class AuthService {

  Users? _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }


  Future SignUp(GlobalKey<FormState> formKey, BuildContext context,String name, String email,
      String password , CreatedAt) async {

    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return const Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,));
        });

    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);

      User? user = userCredential.user;

      print("data-- ${_userFromFirebaseUser(user!)!.uid}");
      await DatabaseService(uid: user.uid).saveUserData(name,"","","","","", CreatedAt);

    }on FirebaseAuthException catch(e){

      Utils.showSnackbar(e.message);
      print(e);
      Navigator.pop(context);
      return;
    }
    print("data-*- ");
    Navigator.pop(context);

    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const AddInfoScreen()),
    );

   // navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }

  Future Login(GlobalKey<FormState> formKey, BuildContext context, String email, String password) async {

    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return const Center(child: CircularProgressIndicator(color: Constant.searchTopBarColor,));
        });

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);

      User? user = userCredential.user;

      print("data-- ${_userFromFirebaseUser(user!)!.uid}");

    }on FirebaseAuthException catch(e){

      Utils.showSnackbar(e.message);
      print(e);

      Navigator.pop(context);

      return;
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }


}

