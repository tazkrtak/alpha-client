class Ticket {
  String id;
  String totp;
  int quantity;
  double fees;

  get data => '$id;$totp;$quantity;$fees';

  get encryptedData {
    // TODO: Encrypt data before returning
    return data;
  }

  Ticket({
    this.id,
    this.totp,
    this.quantity,
    this.fees,
  });

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
