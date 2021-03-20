enum TypeOfUser { student, admin }

class AppUser {
  final String name;
  final String email;
  final TypeOfUser userType;
  final String uuid;

  AppUser({this.name, this.email, this.userType, this.uuid});

  toJson() {
    return {"name": name, "email": email, "userType": userType, "uuid": uuid};
  }
}
