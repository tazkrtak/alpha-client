import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrContainer extends StatelessWidget {
  static const double _SIZE = 240;
  final String data;

  QrContainer({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        data.isNotEmpty
            ? QrImage(
                data: data,
                version: QrVersions.auto,
                size: _SIZE,
                gapless: true,
                foregroundColor: Colors.green[700],
              )
            : Container(
                width: _SIZE,
                height: _SIZE,
                child: Center(
                  child: SizedBox(
                    width: _SIZE / 4,
                    height: _SIZE / 4,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green[700],
                    ),
                  ),
                ),
              ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(data, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
