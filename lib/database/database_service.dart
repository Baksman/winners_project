import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';
import 'package:project/ui/utils/log_utils.dart';
// import 'package:project/ui/utils/log_utils.dart';

enum ComplaintType { Security, Fire, Water, Electricity }

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
          .collection("complaint")
          .doc(complaint.complaintID)
          .set(complaint.toMap());
      return true;
    } catch (e) {
      showFlushBarWidget("Error occured please try again").show(context);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static Future<List<Complaint>> getUsersComplaints(String userId) async {
    QuerySnapshot qSnap = await firestore
        .collection("complaint")
        .where("userId", isEqualTo: userId).orderBy("timeStamp",descending: true)
        .get();

    List<Complaint> complaints = [];

    qSnap.docs.map((element) {
      logger.d(element.id);
      complaints.add(Complaint.fromMap(element.data()));
    }).toList();
    logger.d("got here");
    return complaints;
  }

  Stream<QuerySnapshot> getRecentComplaints(String userId) {
    Stream<QuerySnapshot> qSnap = firestore
        .collection("complaint")
        .where("userId", isEqualTo: userId)
        .limit(3)
        .snapshots();
    return qSnap;
  }
}
