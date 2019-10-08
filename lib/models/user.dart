class User {
  String name;
  String email;
  String nationalId;
  String phoneNumber;
  String password;
  double balance;
  String sharedKey;

  static final User _user = User._internal();

  factory User() {
    return _user;
  }

  User._internal();
}
