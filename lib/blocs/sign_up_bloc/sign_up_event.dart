import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super(props);
}

class NameChanged extends SignUpEvent {
  final String name;

  NameChanged({@required this.name}) : super([name]);

  @override
  String toString() => 'NameChanged { email :$name }';
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

class PhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  PhoneNumberChanged({@required this.phoneNumber}) : super([phoneNumber]);

  @override
  String toString() => 'PhoneNumberChanged { phoneNumber: $phoneNumber }';
}


class PasswordChanged extends SignUpEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  final String password;

  ConfirmPasswordChanged({@required this.password, @required this.confirmPassword}) : super([password,confirmPassword]);

  @override
  String toString() => 'PasswordChanged { password: $password and confirmPassword: $confirmPassword }';
}

class Submitted extends SignUpEvent {
  final User user;

  Submitted(this.user) : super([user]);

  @override
  String toString() {
    return 'Submitted { user: $user }';
  }
}
