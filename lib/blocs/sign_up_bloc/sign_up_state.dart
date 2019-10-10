import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isEmailValid;
  final bool isNationalIdValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isNationalIdValid && isPasswordValid;

  SignUpState({
    this.isEmailValid = false,
    this.isNationalIdValid = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory SignUpState.empty() {
    return SignUpState(
      isEmailValid: true,
      isNationalIdValid: true,
      isPasswordValid: true,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isEmailValid: true,
      isNationalIdValid: true,
      isPasswordValid: true,
      isSubmitting: true,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isEmailValid: true,
      isNationalIdValid: true,
      isPasswordValid: true,
      isFailure: true,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isEmailValid: true,
      isNationalIdValid: true,
      isPasswordValid: true,
      isSuccess: true,
    );
  }

  SignUpState update({
    bool isEmailValid,
    bool isNationalIdValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isNationalIdValid: isNationalIdValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isEmailValid,
    bool isNationalIdValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNationalIdValid: isNationalIdValid ?? this.isNationalIdValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignUpState {
      isEmailValid: $isEmailValid,
      isNationalIdValid: $isNationalIdValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
