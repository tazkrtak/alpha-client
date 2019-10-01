import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/async.dart';
import 'otp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tazkrtak',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String secret = 'lorem-ipsum';
  int _totp;
  int _counterStart = 30;
  int _counterCurrent = 30;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _counterStart),
      new Duration(seconds: 1),
    );

    var countDownListener = countDownTimer.listen(null);

    countDownListener.onData((duration) {
      setState(() {
        _counterCurrent = _counterStart - duration.elapsed.inSeconds;
      });
    });

    countDownListener.onDone(() {
      setState(() {
        _totp = OTP.generateTOTPCode(
            secret, DateTime.now().toUtc().millisecondsSinceEpoch);
      });
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: '$_totp',
              version: QrVersions.auto,
              size: 320,
              gapless: true,
              foregroundColor: Colors.green[700],
            ),
            SizedBox(height: 24),
            Text(_counterCurrent.toString(),
                style: TextStyle(color: Colors.black87, fontSize: 24)),
            FlatButton(
              onPressed: () {
                startTimer();
              },
              child: Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
