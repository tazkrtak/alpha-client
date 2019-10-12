import 'dart:convert';
import 'dart:math';

class SecretGenerator {
  static final Random _random = Random.secure();

  static String generate([int length = 16]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}
