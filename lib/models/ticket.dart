import 'package:encrypt/encrypt.dart';

class Ticket {
  String id;
  String totp;
  int quantity;
  double fees;

  get data => '$id;$totp;$quantity;$fees';

  get encryptedData {
    return _encrypt(data);
  }

  Ticket({
    this.id,
    this.totp,
    this.quantity,
    this.fees,
  });

  String _encrypt(String encryptedText) {
    final key = Key.fromUtf8('TAZKRTAKTAZKRTAK');
    final iv = IV.fromUtf8('TAZKRTAKTAZKRTAK');
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(encryptedText, iv: iv);
    return encrypted.base64;
  }

  @override
  String toString() {
    return '''Ticket{
      id: $id,
      totp: $totp,
      quantity: $quantity,
      fees: $fees,
      data: $data,
      encryptedData: $encryptedData
    }''';
  }
}
