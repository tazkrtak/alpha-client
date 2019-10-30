import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isNameValid;
  final bool isEmailValid;
  final bool isNationalIdValid;
  final bool isPhoneNumberValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isEmailUsed;
  final bool isNationalIdUsed;
  final bool isPhoneNumberUsed;
  final bool isEmailChecked;
  final bool isNationalIdChecked;
  final bool isPhoneNumberChecked;
  final bool isChecking;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isEmailUnique => isEmailChecked && !isEmailUsed;

  bool get isPhoneNumberUnique => isPhoneNumberChecked && !isPhoneNumberUsed;

  bool get isNationalIdUnique => isNationalIdChecked && !isNationalIdUsed;

  SignUpState({
    this.isNameValid = false,
    this.isEmailValid = false,
    this.isNationalIdValid = false,
    this.isPhoneNumberValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isEmailUsed = false,
    this.isNationalIdUsed = false,
    this.isPhoneNumberUsed = false,
    this.isEmailChecked = false,
    this.isNationalIdChecked = false,
    this.isPhoneNumberChecked = false,
    this.isChecking = false,
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

  factory SignUpState.checking() {
    return SignUpState(
      isNameValid: true,
      isEmailValid: true,
      isNationalIdValid: true,
      isPhoneNumberValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isChecking: true,
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
    bool isNameValid,
    bool isEmailValid,
    bool isNationalIdValid,
    bool isPhoneNumberValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isEmailUsed,
    bool isNationalIdUsed,
    bool isPhoneNumberUsed,
    bool isEmailChecked,
    bool isNationalIdChecked,
    bool isPhoneNumberChecked,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isEmailValid: isEmailValid,
      isNationalIdValid: isNationalIdValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isEmailUsed: isEmailUsed,
      isNationalIdUsed: isNationalIdUsed,
      isPhoneNumberUsed: isPhoneNumberUsed,
      isEmailChecked: isEmailChecked,
      isNationalIdChecked: isNationalIdChecked,
      isPhoneNumberChecked: isPhoneNumberChecked,
      isChecking: false,
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
    bool isEmailUsed,
    bool isNationalIdUsed,
    bool isPhoneNumberUsed,
    bool isEmailChecked,
    bool isNationalIdChecked,
    bool isPhoneNumberChecked,
    bool isSubmitEnabled,
    bool isChecking,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNationalIdValid: isNationalIdValid ?? this.isNationalIdValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isEmailUsed: isEmailUsed ?? this.isEmailUsed,
      isNationalIdUsed: isNationalIdUsed ?? this.isNationalIdUsed,
      isPhoneNumberUsed: isPhoneNumberUsed ?? this.isPhoneNumberUsed,
      isEmailChecked: isEmailChecked ?? this.isEmailChecked,
      isNationalIdChecked: isNationalIdChecked ?? this.isNationalIdChecked,
      isPhoneNumberChecked: isPhoneNumberChecked ?? this.isPhoneNumberChecked,
      isChecking: isChecking ?? this.isChecking,
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
      isEmailUsed: $isEmailUsed,
      isNationalIdUsed: $isNationalIdUsed,
      isPhoneNumberUsed, $isPhoneNumberUsed,
      isEmailChecked: $isEmailChecked,
      isNationalIdChecked: $isNationalIdChecked,
      isPhoneNumberChecked: $isPhoneNumberChecked,
      isChecking: $isChecking,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
