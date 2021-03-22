import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/user_model.dart';

class DatabaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> addUser(AppUser user) async {
    await firestore.doc("users").collection(user.uuid).doc().set(user.toJson());
  }
}
