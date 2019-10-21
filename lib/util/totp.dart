import 'package:otp/otp.dart';

class TOTP extends OTP {
  static const REFRESH_INTERVAL = 30;
  static const LENGTH = 6;

  static int get _nowMilliSeconds =>
      DateTime.now().toUtc().millisecondsSinceEpoch;

  static int get _nowSeconds => (_nowMilliSeconds ~/ 1000).round();

  static int get expiresIn =>
      REFRESH_INTERVAL - _nowSeconds % REFRESH_INTERVAL - 1;

  static String generateCode(String secret) {
    return OTP
        .generateTOTPCode(
          secret,
          _nowMilliSeconds,
          length: LENGTH,
          interval: REFRESH_INTERVAL,
        )
        .toString()
        .padLeft(6, '0');
  }

  static String generateSecret() => OTP.randomSecret();
}
