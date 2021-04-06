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

  Future<bool> addSpecificComplaint(
      Complaint complaint, BuildContext context, String complaintType) async {
    _isLoading = true;
    notifyListeners();
    try {
      await firestore
          .collection("compliant")
          .doc(complaint.userId)
          .collection("complaintType")
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

  static Future<List<Complaint>> getSpecificComplaint(
      String userId, String complaintType) async {
    QuerySnapshot qSnap = await firestore
        .collection("compliant")
        .doc(userId)
        .collection("my_complaint")
        .orderBy("timeStamp", descending: true)
        .get();
    List<Complaint> complaints = [];

    // logger.d(qSnap.docs.last.get("hostel"));
    qSnap.docs.map((element) {
      logger.d(element.id);
      complaints.add(Complaint.fromMap(element.data()));
    }).toList();
    logger.d("got here");
    return complaints;
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
      showFlushBarWidget("Error occured please try again").show(context);
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
        .orderBy("timeStamp", descending: true)
        .get();
    List<Complaint> complaints = [];

    // logger.d(qSnap.docs.last.get("hostel"));
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
        .doc(userId)
        .collection("my_complaint")
        .limit(3)
        .snapshots();
    return qSnap;
    //   logger.d(userId);
    //   qSnap.length.then((value) => logger.d(value));
    //   logger.d("got here");
    // qSnap.first.then((value) => logger.d(value.size));
    //   // List<Complaint> complaints = [];
    //   qSnap.listen((event) {
    //     event.docs
    //         .map((e) => streamController.sink.add(Complaint.fromMap(e.data())))
    //         .toList();
    //   });
    //   streamController.stream.length.then((value) => logger.d(value));
    //   return streamController.stream;
  }
}
