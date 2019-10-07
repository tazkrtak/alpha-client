import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/async.dart';
import 'otp.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _Counter = 1;
  int _priceCounter =5;
  String secret = 'lorem-ipsum';
  int _totp;
  int _counterStart = 30;
  int _counterCurrent = 30;

  // Money Counter
  void _decremenetCounter() {
    setState(() {
      if (_Counter > 1) {
        _Counter--;
      }
    });
  }
  void _incrementCounter() {
    setState(() {
      _Counter++;
    });
  }

  // Price Counter
   void _decremenetPriceCounter() {
    setState(() {
      if (_priceCounter > 0) {
        _priceCounter--;
      }
    });
  }
  void _incrementPriceCounter() {
    setState(() {
      _priceCounter++;
    });
  }


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
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 5.0,
              percent: _counterCurrent*(1/30),
              center: new Icon(
                Icons.directions_bus,
                size: 30.0,
                color: Colors.green,
              ),
              backgroundColor: Colors.white,
              progressColor: Colors.yellow,
            ),
            QrImage(
              data: '$_totp',
              version: QrVersions.auto,
              size: 240,
              gapless: true,
              foregroundColor: Colors.green[700],
            ),
            Text('العدد',
                style: TextStyle(color: Colors.black87, fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 40,
                    height: 40,
                    child: new RawMaterialButton(
                      fillColor: Colors.red,
                      shape: new CircleBorder(),
                      elevation: 4,
                      child: new Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        _decremenetCounter();
                      },
                    )
                ),
                Padding(padding: EdgeInsets.only(right: 32)),
                Text(_Counter.toString(),
                    style: TextStyle(color: Colors.black87, fontSize: 24)),
                Padding(padding: EdgeInsets.only(right: 32)),
                Container(
                    width: 40,
                    height: 40,
                    child: new RawMaterialButton(
                      fillColor: Colors.green,
                      shape: new CircleBorder(),
                      elevation: 4,
                      child: new Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        _incrementCounter();
                      },
                    )
                ),
              ],
            ),
             Text('السعر',
                style: TextStyle(color: Colors.black87, fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                width: 40,
                height: 40,
                child: new RawMaterialButton(
                  fillColor: Colors.red,
                  shape: new CircleBorder(),
                  elevation: 4,
                  child: new Icon(
                   Icons.remove,
                    color: Colors.white,
                  ),
                  onPressed: _decremenetPriceCounter,
                )
                ),
                Padding(padding: EdgeInsets.only(right: 32)),
                Text(_priceCounter.toString(),
                    style: TextStyle(color: Colors.black87, fontSize: 24)),
                Padding(padding: EdgeInsets.only(right: 32)),
                Container(
                    width: 40,
                    height: 40,
                    child: new RawMaterialButton(
                      fillColor: Colors.green,
                      shape: new CircleBorder(),
                      elevation: 4,
                      child: new Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        _incrementPriceCounter();
                        startTimer();/*ToDo: Add this line to work automatically*/
                      },
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
