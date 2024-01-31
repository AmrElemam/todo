class User {
  static const String collectionName = "Users";
  String? id;
  String? fullName;
  String? userName;
  String? email;

  User({this.id, this.fullName, this.userName, this.email});

  User.fromfirestore(Map<String, dynamic>? data) {
    id = data?["id"];
    fullName = data?["fullName"];
    userName = data?["userName"];
    email = data?["email"];
  }

  Map<String, dynamic> tofirestore() {
    return {
      "id": id,
      "fullName": fullName,
      "userName": userName,
      "email": email
    };
  }
}
