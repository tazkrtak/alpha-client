import 'package:meta/meta.dart';

@immutable
class SignInState {
  final bool isNationalIdValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNationalIdValid && isPasswordValid;

  SignInState({
    this.isNationalIdValid = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory SignInState.empty() {
    return SignInState(isNationalIdValid: true, isPasswordValid: true);
  }

  factory SignInState.loading() {
    return SignInState(
      isNationalIdValid: true,
      isPasswordValid: true,
      isSubmitting: true,
    );
  }

  factory SignInState.failure() {
    return SignInState(
      isNationalIdValid: true,
      isPasswordValid: true,
      isFailure: true,
    );
  }

  factory SignInState.success() {
    return SignInState(
      isNationalIdValid: true,
      isPasswordValid: true,
      isSuccess: true,
    );
  }

  SignInState update({
    bool isNationalIdValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isNationalIdValid: isNationalIdValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignInState copyWith({
    bool isNationalIdValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignInState(
      isNationalIdValid: isNationalIdValid ?? this.isNationalIdValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignInState {
      isNationalIdValid: $isNationalIdValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
