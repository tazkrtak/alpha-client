import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

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
  final User user;

  Submitted(this.user) : super([user]);

  @override
  String toString() {
    return 'Submitted { user: $user }';
  }
}
