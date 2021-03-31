import 'package:cloud_firestore/cloud_firestore.dart';

enum TypeOfUser { student, admin }

class AppUser {
  final String name;
  final String email;
  final String userType;
  String uuid;
  final String department;
  final String imageUrl;
  final String gender;
  final String faculty;
  final String hostel;
  final String roomNumber;
  final Timestamp dateRegistered;
  final String matricNumber;
  final String mobileNumber;

  AppUser(
      {this.name,
      this.email,
      this.mobileNumber,
      this.userType,
      this.matricNumber,
      this.faculty,
      this.roomNumber,
      this.uuid,
      this.department,
      this.dateRegistered,
      this.gender,
      this.hostel,
      this.imageUrl});
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        name: map['name'] ?? "",
        email: map['email'] ?? "",
        uuid: map['uuid'] ?? "",
        department: map['department'] ?? "",
        imageUrl: map['imageUrl'] ?? "",
        gender: map['gender'] ?? "",
        hostel: map['hostel'] ?? "",
        faculty: map["faculty"] ?? "",
        roomNumber: map['roomNumber'] ?? "",
        matricNumber: map['matricNumber'] ?? "",
        mobileNumber: map['mobileNumber'] ?? "",
        // dateRegistered: map["dateRegistered"] ?? "",
        userType: map["userType"] ?? "");
  }

  toJson() {
    return {
      "dateReg": dateRegistered,
      "matricNo": matricNumber,
      "hostel": hostel,
      "department": department,
      "imageUrl": imageUrl,
      "roomNumber": roomNumber,
      "gender": gender,
      "name": name,
      "email": email,
      "userType": userType,
      "faculty": faculty,
      "uuid": uuid,
      "mobileNo": mobileNumber,
    };
  }
}
