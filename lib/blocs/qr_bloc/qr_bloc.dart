import 'dart:async';

import 'package:bloc/bloc.dart';

import '../qr_bloc/bloc.dart';

class QrBloc extends Bloc<QrEvent, String> {
  @override
  String get initialState => "";

  @override
  Stream<String> mapEventToState(QrEvent event) async* {
    yield event.data;
  }
}
