import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tazkrtak/models/feedback.dart';

class FeedbacksRepository {
  static final firestore.Firestore _db = firestore.Firestore.instance;

  static void setFeedback({
    String userNationalId,
    String message,
    double rating,
  }) async {
    var feedbackRef = _db.collection('feedbacks').document();
    var feedback = Feedback(
        id: feedbackRef.documentID,
        userNationalId: userNationalId,
        message: message,
        rating: rating,
        timestamp: Timestamp.now());

    feedbackRef.setData(feedback.toMap());
  }
}
