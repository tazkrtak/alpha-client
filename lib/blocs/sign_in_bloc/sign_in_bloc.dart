import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../repos/user_repository.dart';
import '../../util/validators.dart';
import 'bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => SignInState.empty();

  @override
  Stream<SignInState> transformEvents(
    Stream<SignInEvent> events,
    Stream<SignInState> Function(SignInEvent event) next,
  ) {
    final observableStream = events as Observable<SignInEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! NationalIdChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is NationalIdChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is NationalIdChanged) {
      yield* _mapEmailChangedToState(event.nationalId);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SignInPressed) {
      yield* _mapSignInPressedToState(
        nationalId: event.nationalId,
        password: event.password,
      );
    }
  }

  Stream<SignInState> _mapEmailChangedToState(String nationalId) async* {
    yield currentState.update(
      isNationalIdValid: Validators.isValidNationalId(nationalId),
    );
  }

  Stream<SignInState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignInState> _mapSignInPressedToState({
    String nationalId,
    String password,
  }) async* {
    yield SignInState.loading();
    try {
      await UserRepository.signIn(nationalId, password);
      yield SignInState.success();
    } catch (_) {
      yield SignInState.failure();
    }
  }
}
