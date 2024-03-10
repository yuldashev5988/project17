class User {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> map) {
    firstName = map["firstName"];
    lastName = map["lastName"];
    email = map["email"];
    password = map["password"];
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      };
}
