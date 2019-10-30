import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tazkrtak/widgets/rounded_button.dart';

import '../util/app_localizations.dart';
import 'outlined_text_field.dart';

typedef void OnFeedbackSubmitted(String text, double rate);

class FeedbackDialog extends StatefulWidget {
  final OnFeedbackSubmitted onFeedbackSubmitted;
  FeedbackDialog({this.onFeedbackSubmitted});

  @override
  FeedbackDialogState createState() => FeedbackDialogState();
}

class FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController feedbackController = TextEditingController();

  var _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context).translate('send_feedback'),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(height: 8),
            Text(AppLocalizations.of(context).translate('feedback_body')),
            SizedBox(height: 16),
            RatingBar(
              initialRating: 3,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
              ),
              onRatingUpdate: (double value) {
                _rating = value;
              },
            ),
            SizedBox(height: 16),
            OutlinedTextField(
              textKey: 'feedback_message',
              keyboardType: TextInputType.multiline,
              controller: feedbackController,
            ),
            SizedBox(height: 16),
            RoundedButton(
              textKey: 'send_feedback',
              onPressed: () {
                widget.onFeedbackSubmitted(feedbackController.text, _rating);
                feedbackController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
