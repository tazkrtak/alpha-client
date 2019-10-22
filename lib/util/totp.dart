import 'dart:math';

import 'package:base32/base32.dart';
import 'package:otp/otp.dart';

class TOTP {
  static const INTERVAL = 30;
  static const LENGTH = 6;

  static int get _now => DateTime.now().millisecondsSinceEpoch;

  static int get expiresIn => INTERVAL - (_now ~/ 1000) % INTERVAL - 1;

  static String generateCode(String secret) {
    return OTP
        .generateTOTPCode(
          secret,
          _now,
          length: LENGTH,
          interval: INTERVAL,
        )
        .toString()
        .padLeft(6, '0');
  }

  static String generateSecret() {
    var random = Random.secure();
    var values = List<int>.generate(10, (i) => random.nextInt(256));
    return base32.encode(values);
  }
}
