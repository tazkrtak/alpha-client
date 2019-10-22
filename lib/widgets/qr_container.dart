import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrContainer extends StatelessWidget {
  static const double _SIZE = 232;
  final String data;

  QrContainer({this.data});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? QrImage(
            data: data,
            version: QrVersions.auto,
            size: _SIZE,
            gapless: true,
            foregroundColor: Theme.of(context).primaryColorDark,
          )
        : Container(
            width: _SIZE,
            height: _SIZE,
            child: Center(
              child: SizedBox(
                width: _SIZE / 4,
                height: _SIZE / 4,
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
  }
}
