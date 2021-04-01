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
  final String dateRegistered;
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
        name: (map['name'] ?? "").toString().toUpperCase(),
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
        dateRegistered: map["dateReg"] ?? "",
        userType: map["userType"] ?? "");
  }
  AppUser copyWith({
    String name,
    String email,
    String userType,
    String uuid,
    String department,
    String imageUrl,
    String gender,
    String faculty,
    String hostel,
    String roomNumber,
    String dateRegistered,
    String matricNumber,
    String mobileNumber,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      uuid: uuid ?? this.uuid,
      department: department ?? this.department,
      imageUrl: imageUrl ?? this.imageUrl,
      gender: gender ?? this.gender,
      faculty: faculty ?? this.faculty,
      hostel: hostel ?? this.hostel,
      roomNumber: roomNumber ?? this.roomNumber,
      dateRegistered: dateRegistered ?? this.dateRegistered,
      matricNumber: matricNumber ?? this.matricNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  toJson() {
    return {
      "dateReg": dateRegistered,
      "matricNumber": matricNumber,
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
