import 'package:equatable/equatable.dart';
import 'package:tazkrtak/models/ticket.dart';

class QrEvent extends Equatable {
  final Ticket ticket;

  QrEvent(this.ticket);

  @override
  String toString() {
    return '''QrEvent { ticket: $ticket }''';
  }
}
