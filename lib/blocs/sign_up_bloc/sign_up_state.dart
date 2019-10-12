import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isNameValid;
  final bool isEmailValid;
  final bool isNationalIdValid;
  final bool isPhoneNumberValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isNameValid &&
      isEmailValid &&
      isNationalIdValid &&
      isPhoneNumberValid &&
      isPasswordValid &&
      isConfirmPasswordValid;

  SignUpState({
    this.isNameValid = false,
    this.isEmailValid = false,
    this.isNationalIdValid = false,
    this.isPhoneNumberValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory SignUpState.empty() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isNationalIdValid: true,
      isPhoneNumberValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isNationalIdValid: true,
      isPhoneNumberValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: true,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isNationalIdValid: true,
      isPhoneNumberValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isFailure: true,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isNationalIdValid: true,
      isPhoneNumberValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSuccess: true,
    );
  }

  SignUpState update({
    bool isNameValid: true,
    bool isEmailValid,
    bool isNationalIdValid,
    bool isPhoneNumberValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isEmailValid: isEmailValid,
      isNationalIdValid: isNationalIdValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isNameValid,
    bool isEmailValid,
    bool isNationalIdValid,
    bool isPhoneNumberValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isNameValid: isNameValid?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNationalIdValid: isNationalIdValid ?? this.isNationalIdValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignUpState {
      isNameValid: $isNameValid,
      isEmailValid: $isEmailValid,
      isNationalIdValid: $isNationalIdValid,
      isPhoneNumberValid: $isPhoneNumberValid,
      isPasswordValid: $isPasswordValid,
      isConfirmPasswordValid: $isConfirmPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
