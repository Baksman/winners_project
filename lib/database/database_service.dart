import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';
import 'package:project/ui/utils/log_utils.dart';
// import 'package:project/ui/utils/log_utils.dart';

class DatabaseService extends ChangeNotifier {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static Future<void> addUser(AppUser user) async {
    await firestore.collection("users").doc(user.uuid).set(user.toJson());
  }

  static Future<AppUser> getUserData(String uuid) async {
    DocumentSnapshot docSnap =
        await firestore.collection("users").doc(uuid).get();
    return AppUser.fromMap(docSnap.data());
  }

  Future<bool> addCompliant(Complaint complaint, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await firestore
          .collection("compliant")
          .doc(complaint.userId)
          .collection("my_complaint")
          .doc(complaint.complaintID)
          .set(complaint.toMap());
      return true;
    } catch (e) {
      show_flushbar("Error occured please try again").show(context);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static Future<List<Complaint>> getUsersComplaints(String userId) async {
    QuerySnapshot qSnap = await firestore
        .collection("compliant")
        .doc(userId)
        .collection("my_complaint")
        .get();
    List<Complaint> complaints = [];
  
    logger.d( qSnap.docs.first.data());
    qSnap.docs.map((element) {
      complaints.add(Complaint.fromMap(element.data()));
    });
        logger.d("got here");
    return complaints;
  }

  static Future<List<Complaint>> getRecentComplaints(String userId) async {
    Stream<QuerySnapshot> qSnap = firestore
        .collection("complaint")
        .doc(userId)
        .collection("my_complaint")
        .snapshots();

    List<Complaint> complaints = [];
    qSnap.map((event) =>
        event.docs.map((e) => complaints.add(Complaint.fromMap(e.data()))));

    return complaints;
  }
}
