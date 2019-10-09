import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super(props);
}

class EmailChanged extends SignUpEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class NationalIdChanged extends SignUpEvent {
  final String nationalId;

  NationalIdChanged({@required this.nationalId}) : super([nationalId]);

  @override
  String toString() => 'NationalIdChanged { nationalId :$nationalId }';
}

class PasswordChanged extends SignUpEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends SignUpEvent {
  final String nationalId;
  final String password;
  final String name;
  final String email;
  final String phoneNumber;

  Submitted({
    @required this.nationalId,
    @required this.password,
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
  }) : super([email, password]);

  @override
  String toString() {
    return '''Submitted {
      nationalId: $nationalId,
      password: $password,
      name: $name,
      email: $email,
      phoneNumber: $phoneNumber,
    }''';
  }
}
