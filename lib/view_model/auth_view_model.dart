import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<bool> register(
      {String email, String password, BuildContext context}) async {
    notifyListeners();
    try {
      // to sign up
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // to verify ur email
      await userCredential.user.sendEmailVerification();
      _isLoading = false;
      notifyListeners();
      show_flushbar(
              "Account created successfully please verify your email address")
          .show(context);
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        show_flushbar("The password provided is too weak").show(context);
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        show_flushbar("Email already in use").show(context);
      }
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      show_flushbar("Error occured please try again").show(context);
      return false;
    }
  }

  // Stream<AppUser> getUser() {
  //   FirebaseAuth.instance.authStateChanges().listen((User user) {
  //     if (user == null) {
  //       return null;
  //     }
  //       return AppUser(
  //         email: user.email,
  //         uuid: user.uid,
  //       );

  //   });
  // }
  // FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  Future<bool> login(
      {String email, String password, BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _isLoading = false;
      notifyListeners();
      User user = userCredential.user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        show_flushbar(
                "You have not verified your email yet please verify to continue")
            .show(context);
        return false;
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        show_flushbar("user-not-found").show(context);
      } else if (e.code == 'wrong-password') {
        show_flushbar("Wrong password provided for that user.").show(context);
      }
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      show_flushbar("Error occured please try again").show(context);
      return false;
    }
  }
}
