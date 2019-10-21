import 'package:equatable/equatable.dart';

import '../../util/totp.dart';

class QrEvent extends Equatable {
  final String id;
  final String secret;
  final int quantity;
  final double fees;
  String data;

  QrEvent({
    this.id,
    this.secret,
    this.quantity,
    this.fees,
  }) : super([id, secret, quantity, fees]) {
    var totp = TOTP.generateCode(secret);
    data = '$id;$totp;$quantity;$fees';
  }

  @override
  String toString() {
    return '''QrEvent { data: $data }''';
  }
}
