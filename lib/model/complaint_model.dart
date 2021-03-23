import 'dart:convert';

import 'package:flutter/material.dart';

class Complaint {
  final String title;
  final String hostel;
  final String userId;
  final String complaintID;
  final String desc;

  Complaint({
    @required this.title,
    @required this.hostel,
    @required this.userId,
    @required this.complaintID,
    @required this.desc,
  });

  Complaint copyWith({
    String title,
    String hostel,
    String userId,
    String complaintID,
    String desc,
  }) {
    return Complaint(
      title: title ?? this.title,
      hostel: hostel ?? this.hostel,
      userId: userId ?? this.userId,
      complaintID: complaintID ?? this.complaintID,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hostel': hostel,
      'userId': userId,
      'complaintID': complaintID,
      'desc': desc,
    };
  }

  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
      map['title'],
      map['hostel'],
      map['userId'],
      map['complaintID'],
      map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Complaint.fromJson(String source) =>
      Complaint.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Complaint(title: $title, hostel: $hostel, userId: $userId, complaintID: $complaintID, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Complaint &&
        other.title == title &&
        other.hostel == hostel &&
        other.userId == userId &&
        other.complaintID == complaintID &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        hostel.hashCode ^
        userId.hashCode ^
        complaintID.hashCode ^
        desc.hashCode;
  }
}
