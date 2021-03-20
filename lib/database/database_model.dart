import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/user_model.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(AppUser user) async {
    firestore.doc("users").collection(user.uuid).doc();
  }
}
