import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtareb/shared/constant.dart';

part 'moghtareb_state.dart';

class MoghtarebCubit extends Cubit<MoghtarebState> {
  MoghtarebCubit() : super(MoghtarebInitial());
  static MoghtarebCubit get(context) => BlocProvider.of(context);
  late String adminEmail;
  late String adminPassword;
  late String adminId;
  late String email;
  late String password;
  late String userNaem;

  late String registerEmail;
  late String registerPassword;
  late String registerConfirmPassword;
  Color heartColor = kwhiteColor;
  Color changeHeartColor() {
    if (heartColor == kwhiteColor) {
      heartColor = Colors.red;
    } else {
      heartColor = kwhiteColor;
    }
    emit(ChangeHeartColor());

    return heartColor;
  }

  String Id = 'lJ9lQBj3mwORRHgKmaYTrjMnOYi1';

  Future<void> signIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    log(userCredential.user!.email.toString());
    log(userCredential.user!.displayName.toString());
    emit(SignInState());
  }

  Future<void> adminSignIn() async {
    UserCredential userCredential1 = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: adminEmail, password: adminPassword);
    log(userCredential1.user!.email.toString());
    log(userCredential1.user!.displayName.toString());
    emit(AdminSignInState());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      log("sign out");
    }).catchError((error) {
      log("'Sign Out Error', $error");
    });
    emit(SignOutState());
  }

  Future<void> signUp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: registerEmail, password: registerPassword);
    log(user.user!.email.toString());
    emit(SignUpState());
    emit(SignInScreenState());
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  Future<void> deleteAccount() async {
    if (currentUser != null) {
      debugPrint(currentUser!.uid);
      try {
        await FirebaseAuth.instance.currentUser!.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          debugPrint(
              'The user must reauthenticate before this operation can be executed.');
        }
      }
    }
  }
}
