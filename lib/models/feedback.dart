import 'package:cloud_firestore/cloud_firestore.dart';

class Feedback {
  String id;
  String userNationalId;
  String message;
  double rating;
  Timestamp timestamp;

  Feedback(
      {this.id,
      this.userNationalId,
      this.message,
      this.rating,
      this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userNationalId': userNationalId,
      'message': message,
      'rating': rating,
      'timestamp': timestamp
    };
  }
}
