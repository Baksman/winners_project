import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Complaint {
  final String title;
  final String hostel;
  final String userId;
  final String complaintID;
  final String desc;
  final bool isAttended;
  final Timestamp timeStamp;
  final bool isInvalid;

  Complaint(
      {@required this.title,
      @required this.hostel,
      @required this.userId,
      @required this.complaintID,
      @required this.desc,
      this.isInvalid = false,
      this.isAttended = false,
      this.timeStamp});

  Complaint copyWith(
      {String title,
      String hostel,
      String userId,
      String complaintID,
      String desc,
      String timeStamp}) {
    return Complaint(
        title: title ?? this.title,
        hostel: hostel ?? this.hostel,
        userId: userId ?? this.userId,
        complaintID: complaintID ?? this.complaintID,
        desc: desc ?? this.desc,
        isInvalid: isInvalid ?? this.isInvalid,
        isAttended: isAttended ?? this.isAttended);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hostel': hostel,
      'userId': userId,
      'complaintID': complaintID,
      'isInvalid': isInvalid,
      'desc': desc,
      "isAttended": isAttended,
      "timeStamp": Timestamp.now()
    };
  }

  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
        title: map['title'],
        hostel: map['hostel'],
        userId: map['userId'],
        complaintID: map['complaintID'],
        desc: map['desc'],
        isInvalid: map['isInvalid'],
        isAttended: map["isAttended"],
        timeStamp: map["timeStamp"]);
  }

  String toJson() => json.encode(toMap());

  factory Complaint.fromJson(String source) =>
      Complaint.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Complaint(title: $title,isAttended $isAttended hostel: $hostel, userId: $userId, complaintID: $complaintID, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Complaint &&
        other.title == title &&
        other.hostel == hostel &&
        other.userId == userId &&
        other.timeStamp == timeStamp &&
        other.complaintID == complaintID &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        hostel.hashCode ^
        userId.hashCode ^
        complaintID.hashCode ^
        timeStamp.hashCode ^
        desc.hashCode;
  }
}
