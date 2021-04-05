import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart' as dbs;
import 'package:project/model/user_model.dart';
// import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';
import 'package:project/ui/utils/log_utils.dart';
// import 'package:provider/provider.dart';

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
      User user = userCredential.user;
      AppUser _user = AppUser(
          email: user.email,
          dateRegistered: Timestamp.now().toString(),
          imageUrl: "",
          userType: "Student",
          uuid: user.uid);
      dbs.DatabaseService.addUser(_user);
      await sendVerificationEmail(user);
      // await userCredential.user.sendEmailVerification();
      _isLoading = false;
      notifyListeners();
      showFlushBarWidget(
              "Account created successfully,please verify your email address")
          .show(context);
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      showFlushBarWidget(e.message).show(context);
      // if (e.code == 'weak-password') {
      //   showFlushBarWidget("The password provided is too weak").show(context);
      //   // print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   // print('The account already exists for that email.');
      //   showFlushBarWidget("Email already in use").show(context);
      // }
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showFlushBarWidget("Error occured please try again").show(context);
      return false;
    }
  }

  Future<bool> login(
      {String email, String password, BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      logger.w("added succesfully");
      _isLoading = false;
      notifyListeners();

      if (!user.emailVerified) {
        await sendVerificationEmail(user);
        showFlushBarWidget(
                "You have not verified your email yet please verify to continue")
            .show(context);

        return false;
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      logger.d(e);
      showFlushBarWidget(e.message).show(context);
      // if (e.code == 'user-not-found') {
      //   showFlushBarWidget("user-not-found").show(context);
      // } else if (e.code == 'wrong-password') {
      //   showFlushBarWidget("Wrong password provided for that user.").show(context);
      // }
      return false;
    } catch (e) {
      logger.d(e);
      _isLoading = false;
      notifyListeners();
      showFlushBarWidget("Error occured please try again").show(context);
      return false;
    }
  }

  Future<void> sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await auth.sendPasswordResetEmail(email: email);
      showFlushBarWidget("Reset message has been sent to your email")
          .show(context);
    } on FirebaseAuthException catch (e) {
      showFlushBarWidget(e.message).show(context);
    } catch (e) {
      logger.d(e);
      showFlushBarWidget("Error occured please try again").show(context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Stream onAuthChange() {
    return auth.authStateChanges();
  }
}
