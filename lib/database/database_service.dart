import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';

class DatabaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> addUser(AppUser user) async {
    await firestore
        .doc("users")
        .collection(user.uuid)
        .doc(user.uuid)
        .set(user.toJson());
  }

  static Future<AppUser> getUserData(String uuid) async {
    DocumentSnapshot docSnap =
        await firestore.doc("users").collection(uuid).doc(uuid).get();
    return AppUser.fromMap(docSnap.data());
  }

  static Future<void> addCompliant(Complaint complaint) async {
    await firestore
        .doc("compliant")
        .collection(complaint.userId)
        .add(complaint.toMap());
  }

  static Future<List<Complaint>> getUsersComplaints(String userId) async {
    QuerySnapshot qSnap =
        await firestore.doc("compliant").collection(userId).get();
    List<Complaint> complaints = [];
    qSnap.docs.forEach((element) {
      Complaint.fromMap(element.data());
    });
    return complaints;
  }

  static Future<List<Complaint>> getRecentComplaints(String userId) async {
    QuerySnapshot qSnap =
        await firestore.doc("compliant").collection(userId).get();
    List<Complaint> complaints = [];
    qSnap.docs.take(3).toList().forEach((element) {
      Complaint.fromMap(element.data());
    });
    return complaints;
  }
}
