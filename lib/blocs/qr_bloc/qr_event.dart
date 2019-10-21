import 'package:equatable/equatable.dart';

import '../../models/ticket.dart';

class QrEvent extends Equatable {
  final Ticket ticket;

  QrEvent(this.ticket);

  @override
  String toString() => 'QrEvent { ticket: $ticket }';
}
