import 'dart:math';

import 'package:base32/base32.dart';
import 'package:crypto/crypto.dart';

class TOTP {
  static const VALID_DURATION = 30;

  static int get _timeNowMS => DateTime.now().toUtc().millisecondsSinceEpoch;

  static int get _timeNow => _timeNowMS ~/ 1000;

  static int get expiresIn => VALID_DURATION - _timeNow % VALID_DURATION - 1;

  static int generateTOTPCode(String secret, {int length: 6}) {
    int time = _timeNow ~/ VALID_DURATION;
    return _generateCode(secret, time, length);
  }

  static int _generateCode(String secret, int time, int length) {
    length = (length <= 8 && length > 0) ? length : 6;

    var secretList = base32.decode(secret);
    var timeBytes = _int2bytes(time);

    var hmac = Hmac(sha1, secretList);
    var hash = hmac.convert(timeBytes).bytes;

    int offset = hash[hash.length - 1] & 0xf;

    int binary = ((hash[offset] & 0x7f) << 24) |
        ((hash[offset + 1] & 0xff) << 16) |
        ((hash[offset + 2] & 0xff) << 8) |
        (hash[offset + 3] & 0xff);

    return binary % pow(10, length);
  }

  static List _int2bytes(int long) {
    // Represent the input as a 8-bytes array
    var byteArray = [0, 0, 0, 0, 0, 0, 0, 0];
    for (var index = byteArray.length - 1; index >= 0; index--) {
      var byte = long & 0xff;
      byteArray[index] = byte;
      long = (long - byte) ~/ 256;
    }
    return byteArray;
  }
}