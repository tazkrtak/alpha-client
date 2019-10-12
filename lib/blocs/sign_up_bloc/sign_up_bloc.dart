import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/user.dart';
import '../../repos/user_repository.dart';
import '../../util/validators.dart';
import 'bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  @override
  SignUpState get initialState => SignUpState.empty();

  @override
  Stream<SignUpState> transformEvents(
    Stream<SignUpEvent> events,
    Stream<SignUpState> Function(SignUpEvent event) next,
  ) {
    final observableStream = events as Observable<SignUpEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! NameChanged &&
          event is! EmailChanged &&
          event is! NationalIdChanged &&
          event is! PhoneNumberChanged &&
          event is! PasswordChanged &&
          event is! ConfirmPasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is NameChanged ||
          event is EmailChanged ||
          event is NationalIdChanged ||
          event is PhoneNumberChanged ||
          event is PasswordChanged ||
          event is ConfirmPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is NationalIdChanged) {
      yield* _mapNationalIdChangedToState(event.nationalId);
    } else if (event is PhoneNumberChanged) {
      yield* _mapNationalPhoneNumberChangedToState(event.phoneNumber);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.password, event.confirmPassword);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.user);
    }
  }

  Stream<SignUpState> _mapNameChangedToState(String name) async* {
    yield currentState.update(
      isNameValid: name.isNotEmpty,
    );
  }

  Stream<SignUpState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignUpState> _mapNationalIdChangedToState(String nationalId) async* {
    yield currentState.update(
      isNationalIdValid: Validators.isValidNationalId(nationalId),
    );
  }

  Stream<SignUpState> _mapNationalPhoneNumberChangedToState(
      String phoneNumber) async* {
    yield currentState.update(
      isPhoneNumberValid: Validators.isValidPhoneNumber(phoneNumber),
    );
  }

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignUpState> _mapConfirmPasswordChangedToState(
      String password, String confirmPassword) async* {
    yield currentState.update(
      isConfirmPasswordValid: password == confirmPassword,
    );
  }

  Stream<SignUpState> _mapFormSubmittedToState(User user) async* {
    yield SignUpState.loading();
    try {
      await UserRepository.signUp(user);
      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
    }
  }
}
