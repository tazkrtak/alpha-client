import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignInEvent extends Equatable {
  SignInEvent([List props = const []]) : super(props);
}

class NationalIdChanged extends SignInEvent {
  final String nationalId;

  NationalIdChanged({@required this.nationalId}) : super([nationalId]);

  @override
  String toString() => 'NationalIdChanged { nationalId :$nationalId }';
}

class PasswordChanged extends SignInEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends SignInEvent {
  final String nationalId;
  final String password;

  Submitted({@required this.nationalId, @required this.password})
      : super([nationalId, password]);

  @override
  String toString() {
    return 'Submitted { nationalId: $nationalId, password: $password }';
  }
}

class SignInPressed extends SignInEvent {
  final String nationalId;
  final String password;

  SignInPressed({@required this.nationalId, @required this.password})
      : super([nationalId, password]);

  @override
  String toString() {
    return 'SignInPressed { nationalId: $nationalId, password: $password }';
  }
}
