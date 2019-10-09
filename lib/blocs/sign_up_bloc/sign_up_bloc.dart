import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../repositories//user_repository.dart';
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
      return (event is! EmailChanged &&
          event is! NationalIdChanged &&
          event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged ||
          event is NationalIdChanged ||
          event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is NationalIdChanged) {
      yield* _mapNationalIdChangedToState(event.nationalId);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        nationalId: event.nationalId,
        password: event.password,
        name: event.name,
        email: event.email,
        phoneNumber: event.phoneNumber,
      );
    }
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

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignUpState> _mapFormSubmittedToState({
    String nationalId,
    String password,
    String name,
    String email,
    String phoneNumber,
  }) async* {
    yield SignUpState.loading();
    try {
      await UserRepository.signUp(
        nationalId: nationalId,
        password: password,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );
      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
    }
  }
}
