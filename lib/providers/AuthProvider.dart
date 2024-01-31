// ignore_for_file: file_names, library_prefixes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/UsersDao.dart';
import 'package:todo/database/model/user.dart' as MyUser;

class Authprovider extends ChangeNotifier {
  User? firebaseAuthUser;
  MyUser.User? databaseUser;

  Future<void> register(
      String email, String password, String fullName, String username) async {
    final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await UsersDao.createUser(MyUser.User(
        id: result.user?.uid,
        userName: username,
        fullName: fullName,
        email: email));
  }

  Future<void> login(String email, String password) async {
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var user = await UsersDao.getUser(result.user!.uid);
    databaseUser = user;
    firebaseAuthUser = result.user;
  }

  void logout() {
    databaseUser = null;
    FirebaseAuth.instance.signOut();
  }

  bool isUserLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> retrieveUserFromDatabase() async {
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    databaseUser = await UsersDao.getUser(firebaseAuthUser!.uid);
  }
}
